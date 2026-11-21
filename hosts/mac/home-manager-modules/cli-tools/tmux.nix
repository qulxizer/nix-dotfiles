{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    keyMode = "vi";
    prefix = "C-x";
    terminal = "tmux-256color";

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = tmux-sessionx;
        extraConfig = ''
          set -g @sessionx-bind 'o'
          set -g @sessionx-custom-paths '$HOME/Dev,$HOME/.config'
        '';
      }
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
