{ lib, pkgs, ... }:
let
  mod = "Mod4";
  ws1 = "1:";
  ws2 = "2:";
  ws3 = "3:";
  ws4 = "4:";
  ws5 = "5:";
in
{
  programs.i3status-rust = {
    enable = true;
    bars.top = {
      icons = "material-nf";
      theme = "plain";
      settings = {
        theme = {
          theme = "plain";
          overrides = {
            idle_bg = "#1e1e2e00";
            idle_fg = "#cdd6f4";
            info_bg = "#1e1e2e00";
            info_fg = "#89b4fa";
            good_bg = "#1e1e2e00";
            good_fg = "#a6e3a1";
            warning_bg = "#1e1e2e00";
            warning_fg = "#f9e2af";
            critical_bg = "#1e1e2e00";
            critical_fg = "#f38ba8";
            separator = "  ";
            separator_bg = "#1e1e2e00";
            separator_fg = "#6c7086";
          };
        };
      };
      blocks = [
        {
          block = "cpu";
          interval = 2;
          format = " $icon $utilization ";
        }
        {
          block = "memory";
          format = " $icon $mem_used.eng(prefix:G) ";
        }
        {
          block = "sound";
          format = " $icon {$volume.eng(w:2) |}";
        }
        {
          block = "time";
          interval = 5;
          format = " $icon $timestamp.datetime(f:'%a %d %b  %I:%M %p') ";
        }
        {
          block = "music";
          format = " $icon {$combo.str(max_w:25) $play $next |}";
        }
        {
          block = "temperature";
          chip = "amdgpu-*";
          format = " $icon $max ";
          good = 50;
          idle = 65;
          info = 75;
          warning = 85;
        }
      ];
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    xwayland = true;

    config = {
      modifier = mod;
      terminal = "foot";
      bars = [
        {
          position = "top";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-top.toml";
          extraConfig = ''
            strip_workspace_numbers yes
            workspace_min_width 36
            height 28
          '';
          fonts = {
            names = [ "Iosevka Nerd Font Propo" ];
            size = 10.0;
          };
          colors = {
            background = "#1e1e2ecc"; # transparent mocha
            statusline = "#cdd6f4";
            separator = "#6c7086";
            focusedWorkspace = {
              border = "#cba6f7";
              background = "#cba6f7";
              text = "#1e1e2e";
            };
            activeWorkspace = {
              border = "#6c7086";
              background = "#313244";
              text = "#cdd6f4";
            };
            inactiveWorkspace = {
              background = "#1e1e2e";
              border = "#1e1e2e";
              text = "#6c7086";
            };
            urgentWorkspace = {
              border = "#f38ba8";
              background = "#f38ba8";
              text = "#1e1e2e";
            };
          };
        }
      ];

      gaps = {
        inner = 10;
        outer = 0;
      };

      window = {
        border = 3;
        titlebar = false;
        commands = [
          {
            criteria = {
              app_id = "foot";
            };
            command = "opacity 0.9";
          }
        ];
      };

      floating = {
        border = 3;
        titlebar = false;
        criteria = [
          {
            app_id = "firefox";
            title = "^Picture-in-Picture$";
          }
        ];
      };

      colors = {
        focused = {
          border = "#cba6f7";
          background = "#1e1e2e";
          text = "#cdd6f4";
          indicator = "#cba6f7";
          childBorder = "#cba6f7";
        };
        unfocused = {
          border = "#6c7086";
          background = "#1e1e2e";
          text = "#cdd6f4";
          indicator = "#6c7086";
          childBorder = "#6c7086";
        };
      };

      input = {
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
        };
        "type:pointer" = {
          accel_profile = "flat";
        };
      };

      output = {
        "DP-1" = {
          pos = "1280 0";
        };
      };

      startup = [
        { command = "wl-paste --watch cliphist store"; }
        { command = "awww-daemon"; }
        { command = "awww img ~/nix-dotfiles/wallpapers/musashi.png"; }
        { command = "dunst"; }
      ];
      workspaceOutputAssign = [
        {
          workspace = ws1;
          output = "DP-1";
        }
        {
          workspace = ws2;
          output = "DP-1";
        }
        {
          workspace = ws3;
          output = "DP-1";
        }
        {
          workspace = ws4;
          output = "DP-1";
        }
        {
          workspace = ws5;
          output = "DP-1";
        }
      ];

      keybindings = lib.mkOptionDefault {
        # Apps & launchers
        "${mod}+Return" = "exec foot";
        "${mod}+d" = "exec rofi -show drun";
        "${mod}+b" = "exec brave";
        "${mod}+Alt+l" = "exec swaylock";
        "${mod}+v" =
          ''exec sh -c 'h=$(cliphist list); s=$(echo "$h" | cut -d"$(printf "\t")" -f2- | rofi -dmenu -p "📋" -theme-str "element { children: [ element-text ]; }"); [ -n "$s" ] && echo "$h" | grep -F "$s" | head -n 1 | cliphist decode | wl-copy' '';

        # Window management
        "${mod}+q" = "kill";
        "${mod}+f" = "fullscreen toggle";
        "${mod}+Shift+v" = "floating toggle";

        # Focus (vim + arrows)
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";
        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";

        # Move windows
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";

        # Focus / move across monitors
        "${mod}+Ctrl+h" = "focus output left";
        "${mod}+Ctrl+j" = "focus output down";
        "${mod}+Ctrl+k" = "focus output up";
        "${mod}+Ctrl+l" = "focus output right";
        "${mod}+Shift+Ctrl+h" = "move container to output left";
        "${mod}+Shift+Ctrl+j" = "move container to output down";
        "${mod}+Shift+Ctrl+k" = "move container to output up";
        "${mod}+Shift+Ctrl+l" = "move container to output right";

        "${mod}+u" = "workspace next";
        "${mod}+i" = "workspace prev";
        "${mod}+1" = ''workspace "${ws1}"'';
        "${mod}+2" = ''workspace "${ws2}"'';
        "${mod}+3" = ''workspace "${ws3}"'';
        "${mod}+4" = ''workspace "${ws4}"'';
        "${mod}+5" = ''workspace "${ws5}"'';

        "${mod}+Ctrl+1" = ''move container to workspace "${ws1}"'';
        "${mod}+Ctrl+2" = ''move container to workspace "${ws2}"'';
        "${mod}+Ctrl+3" = ''move container to workspace "${ws3}"'';
        "${mod}+Ctrl+4" = ''move container to workspace "${ws4}"'';
        "${mod}+Ctrl+5" = ''move container to workspace "${ws5}"'';
        "${mod}+Ctrl+6" = "move container to workspace number 6";
        "${mod}+Ctrl+7" = "move container to workspace number 7";
        "${mod}+Ctrl+8" = "move container to workspace number 8";
        "${mod}+Ctrl+9" = "move container to workspace number 9";

        # Quick resize (matches your Mod+- / Mod+=)
        "${mod}+minus" = "resize shrink width 10 ppt";
        "${mod}+equal" = "resize grow width 10 ppt";
        "${mod}+Shift+minus" = "resize shrink height 10 ppt";
        "${mod}+Shift+equal" = "resize grow height 10 ppt";

        # Screenshots (needs grim + slurp installed)
        "Print" =
          ''exec grim -g "$(slurp)" ~/Pictures/Screenshots/Screenshot-$(date +%Y-%m-%d-%H-%M-%S).png'';
        "Ctrl+Print" = "exec grim ~/Pictures/Screenshots/Screenshot-$(date +%Y-%m-%d-%H-%M-%S).png";

        # Session & power
        "${mod}+Shift+e" = "exit";
        "Ctrl+Alt+Delete" = "exit";
        "${mod}+Shift+p" = "output * dpms off";
      };
    };

    # Audio keys with --locked so they work on swaylock
    extraConfig = ''
      bindsym --locked XF86AudioRaiseVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+
      bindsym --locked XF86AudioLowerVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-
      bindsym --locked XF86AudioMute exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bindsym --locked XF86AudioMicMute exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    '';
  };
}
