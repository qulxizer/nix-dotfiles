{
  pkgs,
  inputs,
  ...
}:

let
  inherit (inputs.niri.lib.kdl)
    node
    plain
    leaf
    flag
    ;
in
{
  programs.niri = {
    enable = true;
    package = pkgs.niri;

    config = [
      (leaf "spawn-at-startup" "/usr/lib/polkit-kde-authentication-agent-1")
      (leaf "spawn-sh-at-startup" "wl-paste --watch cliphist store")
      (leaf "spawn-at-startup" "waybar")
      (leaf "spawn-at-startup" "awww-daemon")
      (leaf "spawn-at-startup" [
        "awww"
        "img"
        "~/nix-dotfiles/wallpapers/musashi.png"
      ])
      (leaf "spawn-at-startup" "dunst")
      (leaf "spawn-at-startup" "xwayland-satellite")

      (flag "prefer-no-csd")

      (plain "environment" [
        (leaf "QT_QPA_PLATFORM" "wayland")
        (leaf "DISPLAY" ":0")
      ])

      (plain "window-rule" [
        (leaf "match" { app-id = "com-st-microxplorer-maingui-STM32CubeMX"; })
        (plain "default-column-width" [ (leaf "proportion" 0.6) ])
      ])

      (plain "input" [
        (plain "keyboard" [ (plain "xkb" [ ]) ])
        (plain "touchpad" [
          (flag "tap")
          (flag "natural-scroll")
        ])
        (plain "mouse" [ (leaf "accel-profile" "flat") ])
        (plain "trackpoint" [ ])
      ])

      (node "output" "DP-1" [
        (leaf "mode" "1920x1080@240")
        (leaf "transform" "normal")
        (leaf "position" {
          x = 1280;
          y = 0;
        })
      ])

      (plain "layout" [
        (leaf "gaps" 10)
        (leaf "center-focused-column" "never")

        (plain "preset-column-widths" [
          (leaf "proportion" 0.25)
          (leaf "proportion" 0.5)
          (leaf "proportion" 0.75)
          (leaf "proportion" 1.0)
        ])

        (plain "preset-window-heights" [
          (leaf "proportion" 0.25)
          (leaf "proportion" 0.5)
          (leaf "proportion" 0.75)
          (leaf "proportion" 1.0)
        ])

        (plain "default-column-width" [ (leaf "proportion" 0.5) ])

        (plain "focus-ring" [ (flag "off") ])

        (plain "border" [
          (leaf "width" 3)
          (leaf "active-color" "#cba6f7")
          (leaf "inactive-color" "#6c7086")
        ])
      ])

      (leaf "screenshot-path" "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png")

      (plain "animations" [ ])

      (plain "window-rule" [
        (leaf "geometry-corner-radius" 8)
        (leaf "clip-to-geometry" true)
      ])

      (plain "window-rule" [
        (leaf "match" {
          app-id = "firefox$";
          title = "^Picture-in-Picture$";
        })
        (leaf "open-floating" true)
      ])

      (plain "window-rule" [
        (leaf "match" { app-id = "ghostty$"; })
        (leaf "opacity" 0.9)
      ])

      (plain "binds" [
        (plain "Mod+Shift+Slash" [ (flag "show-hotkey-overlay") ])

        (plain "Mod+Return" [ (leaf "spawn" [ "ghostty" ]) ])
        (plain "Mod+D" [ (leaf "spawn" [ ".config/rofi/launchers/type-1/launcher.sh" ]) ])
        (plain "Mod+B" [ (leaf "spawn" [ "brave" ]) ])
        (plain "Super+Alt+L" [ (leaf "spawn" [ "swaylock" ]) ])

        # Using `node` for binds that need properties (like allow-when-locked or cooldown-ms)
        # Signature: node name args children properties
        (node "XF86AudioRaiseVolume"
          [ ]
          [
            (leaf "spawn" [
              "wpctl"
              "set-volume"
              "@DEFAULT_AUDIO_SINK@"
              "0.1+"
            ])
          ]
          { allow-when-locked = true; }
        )
        (node "XF86AudioLowerVolume"
          [ ]
          [
            (leaf "spawn" [
              "wpctl"
              "set-volume"
              "@DEFAULT_AUDIO_SINK@"
              "0.1-"
            ])
          ]
          { allow-when-locked = true; }
        )
        (node "XF86AudioMute"
          [ ]
          [
            (leaf "spawn" [
              "wpctl"
              "set-mute"
              "@DEFAULT_AUDIO_SINK@"
              "toggle"
            ])
          ]
          { allow-when-locked = true; }
        )
        (node "XF86AudioMicMute"
          [ ]
          [
            (leaf "spawn" [
              "wpctl"
              "set-mute"
              "@DEFAULT_AUDIO_SOURCE@"
              "toggle"
            ])
          ]
          { allow-when-locked = true; }
        )

        (plain "Mod+Q" [ (flag "close-window") ])

        (plain "Mod+Left" [ (flag "focus-column-left") ])
        (plain "Mod+Down" [ (flag "focus-window-down") ])
        (plain "Mod+Up" [ (flag "focus-window-up") ])
        (plain "Mod+Right" [ (flag "focus-column-right") ])
        (plain "Mod+H" [ (flag "focus-column-left") ])
        (plain "Mod+J" [ (flag "focus-window-down") ])
        (plain "Mod+K" [ (flag "focus-window-up") ])
        (plain "Mod+L" [ (flag "focus-column-right") ])

        (plain "Mod+Ctrl+Left" [ (flag "move-column-left") ])
        (plain "Mod+Ctrl+Down" [ (flag "move-window-down") ])
        (plain "Mod+Ctrl+Up" [ (flag "move-window-up") ])
        (plain "Mod+Ctrl+Right" [ (flag "move-column-right") ])
        (plain "Mod+Ctrl+H" [ (flag "move-column-left") ])
        (plain "Mod+Ctrl+J" [ (flag "move-window-down") ])
        (plain "Mod+Ctrl+K" [ (flag "move-window-up") ])
        (plain "Mod+Ctrl+L" [ (flag "move-column-right") ])

        (plain "Mod+Home" [ (flag "focus-column-first") ])
        (plain "Mod+End" [ (flag "focus-column-last") ])
        (plain "Mod+Ctrl+Home" [ (flag "move-column-to-first") ])
        (plain "Mod+Ctrl+End" [ (flag "move-column-to-last") ])

        (plain "Mod+Shift+Left" [ (flag "focus-monitor-left") ])
        (plain "Mod+Shift+Down" [ (flag "focus-monitor-down") ])
        (plain "Mod+Shift+Up" [ (flag "focus-monitor-up") ])
        (plain "Mod+Shift+Right" [ (flag "focus-monitor-right") ])
        (plain "Mod+Shift+H" [ (flag "focus-monitor-left") ])
        (plain "Mod+Shift+J" [ (flag "focus-monitor-down") ])
        (plain "Mod+Shift+K" [ (flag "focus-monitor-up") ])
        (plain "Mod+Shift+L" [ (flag "focus-monitor-right") ])

        (plain "Mod+Shift+Ctrl+Left" [ (flag "move-column-to-monitor-left") ])
        (plain "Mod+Shift+Ctrl+Down" [ (flag "move-column-to-monitor-down") ])
        (plain "Mod+Shift+Ctrl+Up" [ (flag "move-column-to-monitor-up") ])
        (plain "Mod+Shift+Ctrl+Right" [ (flag "move-column-to-monitor-right") ])
        (plain "Mod+Shift+Ctrl+H" [ (flag "move-column-to-monitor-left") ])
        (plain "Mod+Shift+Ctrl+J" [ (flag "move-column-to-monitor-down") ])
        (plain "Mod+Shift+Ctrl+K" [ (flag "move-column-to-monitor-up") ])
        (plain "Mod+Shift+Ctrl+L" [ (flag "move-column-to-monitor-right") ])

        (plain "Mod+Page_Down" [ (flag "focus-workspace-down") ])
        (plain "Mod+Page_Up" [ (flag "focus-workspace-up") ])
        (plain "Mod+U" [ (flag "focus-workspace-down") ])
        (plain "Mod+I" [ (flag "focus-workspace-up") ])
        (plain "Mod+Ctrl+Page_Down" [ (flag "move-column-to-workspace-down") ])
        (plain "Mod+Ctrl+Page_Up" [ (flag "move-column-to-workspace-up") ])
        (plain "Mod+Ctrl+U" [ (flag "move-column-to-workspace-down") ])
        (plain "Mod+Ctrl+I" [ (flag "move-column-to-workspace-up") ])

        (plain "Mod+Shift+Page_Down" [ (flag "move-workspace-down") ])
        (plain "Mod+Shift+Page_Up" [ (flag "move-workspace-up") ])
        (plain "Mod+Shift+U" [ (flag "move-workspace-down") ])
        (plain "Mod+Shift+I" [ (flag "move-workspace-up") ])

        (node "Mod+WheelScrollDown" [ ] [ (flag "focus-workspace-down") ] { cooldown-ms = 150; })
        (node "Mod+WheelScrollUp" [ ] [ (flag "focus-workspace-up") ] { cooldown-ms = 150; })
        (node "Mod+Ctrl+WheelScrollDown" [ ] [ (flag "move-column-to-workspace-down") ] {
          cooldown-ms = 150;
        })
        (node "Mod+Ctrl+WheelScrollUp" [ ] [ (flag "move-column-to-workspace-up") ] { cooldown-ms = 150; })

        (plain "Mod+WheelScrollRight" [ (flag "focus-column-right") ])
        (plain "Mod+WheelScrollLeft" [ (flag "focus-column-left") ])
        (plain "Mod+Ctrl+WheelScrollRight" [ (flag "move-column-right") ])
        (plain "Mod+Ctrl+WheelScrollLeft" [ (flag "move-column-left") ])

        (plain "Mod+Shift+WheelScrollDown" [ (flag "focus-column-right") ])
        (plain "Mod+Shift+WheelScrollUp" [ (flag "focus-column-left") ])
        (plain "Mod+Ctrl+Shift+WheelScrollDown" [ (flag "move-column-right") ])
        (plain "Mod+Ctrl+Shift+WheelScrollUp" [ (flag "move-column-left") ])

        (plain "Mod+1" [ (leaf "focus-workspace" 1) ])
        (plain "Mod+2" [ (leaf "focus-workspace" 2) ])
        (plain "Mod+3" [ (leaf "focus-workspace" 3) ])
        (plain "Mod+4" [ (leaf "focus-workspace" 4) ])
        (plain "Mod+5" [ (leaf "focus-workspace" 5) ])
        (plain "Mod+6" [ (leaf "focus-workspace" 6) ])
        (plain "Mod+7" [ (leaf "focus-workspace" 7) ])
        (plain "Mod+8" [ (leaf "focus-workspace" 8) ])
        (plain "Mod+9" [ (leaf "focus-workspace" 9) ])

        (plain "Mod+Ctrl+1" [ (leaf "move-column-to-workspace" 1) ])
        (plain "Mod+Ctrl+2" [ (leaf "move-column-to-workspace" 2) ])
        (plain "Mod+Ctrl+3" [ (leaf "move-column-to-workspace" 3) ])
        (plain "Mod+Ctrl+4" [ (leaf "move-column-to-workspace" 4) ])
        (plain "Mod+Ctrl+5" [ (leaf "move-column-to-workspace" 5) ])
        (plain "Mod+Ctrl+6" [ (leaf "move-column-to-workspace" 6) ])
        (plain "Mod+Ctrl+7" [ (leaf "move-column-to-workspace" 7) ])
        (plain "Mod+Ctrl+8" [ (leaf "move-column-to-workspace" 8) ])
        (plain "Mod+Ctrl+9" [ (leaf "move-column-to-workspace" 9) ])

        (plain "Mod+BracketLeft" [ (flag "consume-or-expel-window-left") ])
        (plain "Mod+BracketRight" [ (flag "consume-or-expel-window-right") ])

        (plain "Mod+Comma" [ (flag "consume-window-into-column") ])
        (plain "Mod+Period" [ (flag "expel-window-from-column") ])

        (plain "Mod+R" [ (flag "switch-preset-column-width") ])
        (plain "Mod+Shift+R" [ (flag "switch-preset-window-height") ])
        (plain "Mod+Ctrl+R" [ (flag "reset-window-height") ])
        (plain "Mod+F" [ (flag "maximize-column") ])
        (plain "Mod+Shift+F" [ (flag "fullscreen-window") ])
        (plain "Mod+C" [ (flag "center-column") ])

        (plain "Mod+Minus" [ (leaf "set-column-width" "-10%") ])
        (plain "Mod+Equal" [ (leaf "set-column-width" "+10%") ])
        (plain "Mod+Shift+Minus" [ (leaf "set-window-height" "-10%") ])
        (plain "Mod+Shift+Equal" [ (leaf "set-window-height" "+10%") ])

        (plain "Mod+V" [ (flag "toggle-window-floating") ])
        (plain "Mod+Shift+V" [ (flag "switch-focus-between-floating-and-tiling") ])

        (plain "Print" [ (flag "screenshot") ])
        (plain "Ctrl+Print" [ (flag "screenshot-screen") ])
        (plain "Alt+Print" [ (flag "screenshot-window") ])

        (plain "Mod+Shift+E" [ (flag "quit") ])
        (plain "Ctrl+Alt+Delete" [ (flag "quit") ])
        (plain "Mod+Shift+P" [ (flag "power-off-monitors") ])
      ])
    ];
  };
}
