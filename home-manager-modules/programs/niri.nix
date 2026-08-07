{ inputs, pkgs, ... }: {

  imports = [ inputs.niri.homeModules.niri ];
  package = pkgs.niri;

  programs.niri = {

    enable = true;
    settings = {

      prefer-no-csd = true;

      environment = {
        QT_QPA_PLATFORM = "wayland";
        DISPLAY = ":0";
      };

      spawn-at-startup = [
        { command = [ "/usr/lib/polkit-kde-authentication-agent-1" ]; }
        {
          command = [
            "sh"
            "-c"
            "wl-paste --watch cliphist store"
          ];
        }
        { command = [ "waybar" ]; }
        { command = [ "awww-daemon" ]; }
        {
          command = [
            "awww"
            "img"
            "~/nix-dotfiles/wallpapers/musashi.png"
          ];
        }
        { command = [ "dunst" ]; }
        { command = [ "xwayland-satellite" ]; }
      ];

      input = {
        keyboard.xkb = { };
        touchpad = {
          tap = true;
          natural-scroll = true;
        };
        mouse = {
          accel-profile = "flat";
        };
        trackpoint = { };
      };

      outputs."DP-1" = {
        mode = "1920x1080@240";
        transform = "normal";
        position = {
          x = 1280;
          y = 0;
        };
      };

      layout = {
        gaps = 10;
        center-focused-column = "never";
        preset-column-widths = [
          { proportion = 0.25; }
          { proportion = 0.5; }
          { proportion = 0.75; }
          { proportion = 1.0; }
        ];
        preset-window-heights = [
          { proportion = 0.25; }
          { proportion = 0.5; }
          { proportion = 0.75; }
          { proportion = 1.0; }
        ];
        default-column-width = {
          proportion = 0.5;
        };

        focus-ring.enable = false;

        border = {
          width = 3;
          active.color = "#cba6f7";
          inactive.color = "#6c7086";
        };
      };

      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
      animations = { };

      window-rules = [
        {
          matches = [ { app-id = "com-st-microxplorer-maingui-STM32CubeMX"; } ];
          default-column-width = {
            proportion = 0.6;
          };
        }
        {
          geometry-corner-radius = {
            radius = 8;
          };
          clip-to-geometry = true;
        }
        {
          matches = [
            {
              app-id = "firefox$";
              title = "^Picture-in-Picture$";
            }
          ];
          open-floating = true;
        }
        {
          matches = [ { app-id = "ghostty$"; } ];
          opacity = 0.9;
        }
      ];

      binds = {
        "Mod+Shift+Slash".action.show-hotkey-overlay = true;

        "Mod+Return".action.spawn = "ghostty";
        "Mod+D".action.spawn = ".config/rofi/launchers/type-1/launcher.sh";
        "Mod+B".action.spawn = "brave";
        "Super+Alt+L".action.spawn = "swaylock";

        "XF86AudioRaiseVolume" = {
          allow-when-locked = true;
          action.spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "0.1+"
          ];
        };
        "XF86AudioLowerVolume" = {
          allow-when-locked = true;
          action.spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "0.1-"
          ];
        };
        "XF86AudioMute" = {
          allow-when-locked = true;
          action.spawn = [
            "wpctl"
            "set-mute"
            "@DEFAULT_AUDIO_SINK@"
            "toggle"
          ];
        };
        "XF86AudioMicMute" = {
          allow-when-locked = true;
          action.spawn = [
            "wpctl"
            "set-mute"
            "@DEFAULT_AUDIO_SOURCE@"
            "toggle"
          ];
        };

        "Mod+Q".action.close-window = true;

        "Mod+Left".action.focus-column-left = true;
        "Mod+Down".action.focus-window-down = true;
        "Mod+Up".action.focus-window-up = true;
        "Mod+Right".action.focus-column-right = true;
        "Mod+H".action.focus-column-left = true;
        "Mod+J".action.focus-window-down = true;
        "Mod+K".action.focus-window-up = true;
        "Mod+L".action.focus-column-right = true;

        "Mod+Ctrl+Left".action.move-column-left = true;
        "Mod+Ctrl+Down".action.move-window-down = true;
        "Mod+Ctrl+Up".action.move-window-up = true;
        "Mod+Ctrl+Right".action.move-column-right = true;
        "Mod+Ctrl+H".action.move-column-left = true;
        "Mod+Ctrl+J".action.move-window-down = true;
        "Mod+Ctrl+K".action.move-window-up = true;
        "Mod+Ctrl+L".action.move-column-right = true;

        "Mod+Home".action.focus-column-first = true;
        "Mod+End".action.focus-column-last = true;
        "Mod+Ctrl+Home".action.move-column-to-first = true;
        "Mod+Ctrl+End".action.move-column-to-last = true;

        "Mod+Shift+Left".action.focus-monitor-left = true;
        "Mod+Shift+Down".action.focus-monitor-down = true;
        "Mod+Shift+Up".action.focus-monitor-up = true;
        "Mod+Shift+Right".action.focus-monitor-right = true;
        "Mod+Shift+H".action.focus-monitor-left = true;
        "Mod+Shift+J".action.focus-monitor-down = true;
        "Mod+Shift+K".action.focus-monitor-up = true;
        "Mod+Shift+L".action.focus-monitor-right = true;

        "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = true;
        "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = true;
        "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = true;
        "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = true;
        "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = true;
        "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = true;
        "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = true;
        "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = true;

        "Mod+Page_Down".action.focus-workspace-down = true;
        "Mod+Page_Up".action.focus-workspace-up = true;
        "Mod+U".action.focus-workspace-down = true;
        "Mod+I".action.focus-workspace-up = true;

        "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = true;
        "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = true;
        "Mod+Ctrl+U".action.move-column-to-workspace-down = true;
        "Mod+Ctrl+I".action.move-column-to-workspace-up = true;

        "Mod+Shift+Page_Down".action.move-workspace-down = true;
        "Mod+Shift+Page_Up".action.move-workspace-up = true;
        "Mod+Shift+U".action.move-workspace-down = true;
        "Mod+Shift+I".action.move-workspace-up = true;

        "Mod+WheelScrollDown" = {
          cooldown-ms = 150;
          action.focus-workspace-down = true;
        };
        "Mod+WheelScrollUp" = {
          cooldown-ms = 150;
          action.focus-workspace-up = true;
        };
        "Mod+Ctrl+WheelScrollDown" = {
          cooldown-ms = 150;
          action.move-column-to-workspace-down = true;
        };
        "Mod+Ctrl+WheelScrollUp" = {
          cooldown-ms = 150;
          action.move-column-to-workspace-up = true;
        };

        "Mod+WheelScrollRight".action.focus-column-right = true;
        "Mod+WheelScrollLeft".action.focus-column-left = true;
        "Mod+Ctrl+WheelScrollRight".action.move-column-right = true;
        "Mod+Ctrl+WheelScrollLeft".action.move-column-left = true;

        "Mod+Shift+WheelScrollDown".action.focus-column-right = true;
        "Mod+Shift+WheelScrollUp".action.focus-column-left = true;
        "Mod+Ctrl+Shift+WheelScrollDown".action.move-column-right = true;
        "Mod+Ctrl+Shift+WheelScrollUp".action.move-column-left = true;

        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;

        "Mod+Ctrl+1".action.move-column-to-workspace = 1;
        "Mod+Ctrl+2".action.move-column-to-workspace = 2;
        "Mod+Ctrl+3".action.move-column-to-workspace = 3;
        "Mod+Ctrl+4".action.move-column-to-workspace = 4;
        "Mod+Ctrl+5".action.move-column-to-workspace = 5;
        "Mod+Ctrl+6".action.move-column-to-workspace = 6;
        "Mod+Ctrl+7".action.move-column-to-workspace = 7;
        "Mod+Ctrl+8".action.move-column-to-workspace = 8;
        "Mod+Ctrl+9".action.move-column-to-workspace = 9;

        "Mod+BracketLeft".action.consume-or-expel-window-left = true;
        "Mod+BracketRight".action.consume-or-expel-window-right = true;
        "Mod+Comma".action.consume-window-into-column = true;
        "Mod+Period".action.expel-window-from-column = true;

        "Mod+R".action.switch-preset-column-width = true;
        "Mod+Shift+R".action.switch-preset-window-height = true;
        "Mod+Ctrl+R".action.reset-window-height = true;
        "Mod+F".action.maximize-column = true;
        "Mod+Shift+F".action.fullscreen-window = true;
        "Mod+C".action.center-column = true;

        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "+10%";
        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Equal".action.set-window-height = "+10%";

        "Mod+V".action.toggle-window-floating = true;
        "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = true;

        "Print".action.screenshot = true;
        "Ctrl+Print".action.screenshot-screen = true;
        "Alt+Print".action.screenshot-window = true;

        "Mod+Shift+E".action.quit = true;
        "Ctrl+Alt+Delete".action.quit = true;
        "Mod+Shift+P".action.power-off-monitors = true;
      };
    };
  };
}
