{ pkgs, ... }:
let
  sessiony = pkgs.writeShellScriptBin "sessiony" ''
    #!/usr/bin/env bash

    paths=()
    while [[ $# -gt 0 ]]; do
        case "$1" in
        --paths)
            IFS=',' read -r -a paths <<<"$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
        esac
    done

    CHOOSEN=$(
        tmux ls -F "#S" | fzf-tmux -p 60%,60% --border=rounded --margin=0 \
            --header '  A-1 Sessions  A-2 Dirs  A-3 Zoxide  A-d Kill ' \
            --no-sort --ansi --border-label ' Sessiony ' --prompt '  ' \
            --bind "tab:down,btab:up" \
            --bind "alt-1:change-prompt(  )+reload(tmux ls -F '#S')" \
            --bind "alt-2:change-prompt(  )+reload(find -L ''${paths[*]:-.} -maxdepth 1 -type d 2>/dev/null)" \
            --bind "alt-3:change-prompt(  )+reload(zoxide query -l)" \
            --bind "alt-d:execute(tmux kill-session -t {})+change-prompt(  )+reload(tmux ls -F '#S')" \
            --bind "alt-k:up,alt-j:down" \
            --bind "alt-':abort"
    )

    [[ -z "$CHOOSEN" ]] && exit 0

    if tmux has-session -t "=$CHOOSEN" 2>/dev/null; then
        tmux switch-client -t "=$CHOOSEN"
        exit 0
    fi

    SESSION_NAME=$(basename "$CHOOSEN" | tr '.:' '__')
    if ! tmux has-session -t "=$SESSION_NAME" 2>/dev/null; then
        tmux new-session -d -s "$SESSION_NAME" -c "$CHOOSEN"
    fi
    tmux switch-client -t "=$SESSION_NAME"
  '';
in
{
  home.packages = [ sessiony ];

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    keyMode = "vi";
    prefix = "C-x";
    terminal = "tmux-256color";

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
        '';
      }
    ];

    extraConfig = ''
      set-option -sa terminal-overrides ",xterm-256color:RGB"

      # Vi copy mode -> Wayland clipboard
      bind-key -T copy-mode-vi v send -X begin-selection
      bind-key -T copy-mode-vi V send -X select-line
      bind-key -T copy-mode-vi y send -X copy-pipe-and-cancel 'wl-copy'

      # Resize panes
      bind C-h resize-pane -L
      bind C-j resize-pane -D
      bind C-k resize-pane -U
      bind C-l resize-pane -R

      # Navigate panes
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Window switching & swapping
      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9
      bind -n M-w command-prompt -p "Swap with window:" "swap-window -t %1"
      bind m command-prompt -p "send pane to:" "join-pane -t '%%'"

      # Reload
      bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"

      # Sessiony popup
      bind o run-shell "${sessiony}/bin/sessiony --paths $HOME/Dev,$HOME/.config"

      # Catppuccin status bar tweaks (theme itself is handled by catppuccin/nix)
      set -g status-right-length 100
      set -g status-left-length 100
      set -g status-left ""
      set -g status-right "#{E:@catppuccin_status_application}"
      set -ag status-right "#{E:@catppuccin_status_session}"
      set -ag status-right "#{E:@catppuccin_status_uptime}"
      set -ogq @catppuccin_window_text "  #{pane_current_command}"
      set -ogq @catppuccin_window_current_text "  #{pane_current_command}"
    '';
  };
}
