{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    keyMode = "vi";
    extraConfig = ''

      # Additional raw tmux config if needed
      # set -g status-right "%H:%M"
      # ~/.tmux.conf
set-window-option -g mode-keys vi
bind-key -T copy-mode-vi v send -X begin-selection
bind-key -T copy-mode-vi V send -X select-line
bind-key -T copy-mode-vi y send -X copy-pipe-and-cancel 'wl-copy'
# Resize panes
set-option -g prefix C-x
bind C-h resize-pane -L
bind C-j resize-pane -D
bind C-k resize-pane -U
bind C-l resize-pane -R

# Remap arrow keys to hjkl
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# Windows switching
bind -n M-1 select-window -t 1
bind -n M-2 select-window -t 2
bind -n M-3 select-window -t 3
bind -n M-4 select-window -t 4
bind -n M-5 select-window -t 5
bind -n M-6 select-window -t 6
bind -n M-7 select-window -t 7
bind -n M-8 select-window -t 8
bind -n M-9 select-window -t 9

# Swap windows
bind -n M-w command-prompt -p "Swap with window:" "swap-window -t %1"
bind m command-prompt -p "send pane to:"  "join-pane -t '%%'"

# Base Index
set -g base-index 1

#Reload Config
bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"

# Options to make tmux more pleasant
set -g mouse on
set -g default-terminal "tmux-256color"
set-option -sa terminal-overrides ",xterm-256color:RGB"


# For TPM, instead use `run ~/.tmux/plugins/tmux/catppuccin.tmux`

# Make the status line pretty and add some modules
set -g status-right-length 100
set -g status-left-length 100
set -g status-left ""
set -g status-right "#{E:@catppuccin_status_application}"
# set -agF status-right "#{E:@catppuccin_status_cpu}"
set -ag status-right "#{E:@catppuccin_status_session}"
set -ag status-right "#{E:@catppuccin_status_uptime}"
set -ogq @catppuccin_window_text "  #{pane_current_command}"
set -ogq @catppuccin_window_current_text "  #{pane_current_command}"
 
# set -agF status-right "#{E:@catppuccin_status_battery}"

# run ~/.config/tmux/plugins/tmux-plugins/tmux-cpu/cpu.tmux
# run ~/.config/tmux/plugins/tmux-plugins/tmux-battery/battery.tmux
# Or, if using TPM, just run TPM

set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @resurrect-strategy-nvim 'session'
set -g @plugin 'catppuccin/tmux#v2.1.3' 
set -g @plugin 'qulxizer/sessiony'
set -g @sessiony-bind 'o'
set -g @sessiony-custom-paths '$HOME/Dev,$HOME/.config'

run '~/.tmux/plugins/tpm/tpm'
    '';
  };
}

