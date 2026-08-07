{ pkgs, ... }: {
  programs.niri = {
    # package = pkgs.niri;
    enable = true;

    settings = {
      environment = {
        QT_QPA_PLATFORM = "wayland";
        DISPLAY = ":0";
      };

      spawn-at-startup = [
        { command = [ "waybar" ]; }
        { command = [ "dunst" ]; }
      ];

      layout = {
        gaps = 10;
        center-focused-column = "never";
        border = {
          width = 3;
          active.color = "#cba6f7";
          inactive.color = "#6c7086";
        };
      };

      binds = {
        "Mod+Return".action.spawn = [ "ghostty" ];
        "Mod+D".action.spawn = [
          "rofi"
          "-show"
          "drun"
        ];

        "Mod+Q".action.close-window = { };
        "Mod+Shift+E".action.quit = { };

        "Mod+Left".action.focus-column-left = { };
        "Mod+Right".action.focus-column-right = { };
        "Mod+Up".action.focus-window-up = { };
        "Mod+Down".action.focus-window-down = { };

        # The audio binds are way cleaner now
        "XF86AudioRaiseVolume" = {
          allow-when-locked = true;
          action.spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "0.1+"
          ];
        };
      };
    };
  };
}
