{ pkgs, lib, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings =
      let
        terminal = "alacritty";
        browser = "zen";
      in
      {
        "$mod" = "SUPER";
        bind =
          [
            "$mod, B, exec, ${browser}"
            "$mod, T, exec, ${terminal}"
            "$mod, D, exec, wofi --show drun"
            "$mod, M, exit,"
            "$mod, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"
            "$mod, Q, killactive,"
            ", Print, exec, grimblast copy area"

          ] ++ (
            builtins.concatLists (builtins.genList
              (i:
                let ws = i + 1;
                in [
                  "$mod, code:1${toString i}, workspace, ${toString ws}"
                  "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                ]
              )
              9)
          );
        bindm = [
          "bindm = $mod, mouse:272, movewindow"
          "bindm = $mod, mouse:273, resizewindow"
        ];
        general = {
          "gaps_in" = 5;
          "gaps_out" = 10;
          "border_size" = 2;
          "col.active_border" = "rgba(cba6f7aa)";
          "col.inactive_border" = "rgba(595959aa)";
        };
        decoration = {
          "rounding" = 10;
          "active_opacity" = 1.0;
          "inactive_opacity" = 1.0;
          "drop_shadow" = true;
          "shadow_range" = 4;
          "shadow_render_power" = 3;
          "col.shadow" = "rgba(1a1a1aee)";
          blur = {
            "enabled" = true;
            "size" = 3;
            "passes" = 1;
            "vibrancy" = 0.1696;
          };
        };
        monitor = ",1920x1080@165,auto,auto";
        input = {
          "kb_layout" = "us,ara";
          "kb_options" = "grp:win_space_toggle";
          "force_no_accel" = true;
          "sensitivity" = 0;

        };
        exec-once = [
          "ags"
          "hyprctl setcursor Bibata-Modern-Classic 24 &"
          "wl-paste --type text --watch cliphist store"
          "hyprpaper"
        ];
      };


  };
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.magnetic-catppuccin-gtk;
      name = "Catppuccin-GTK-Dark";
    };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };

}
