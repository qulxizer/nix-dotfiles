{ pkgs, ... }:
{
  home.packages = [ pkgs.libnotify ];

  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "Iosevka Nerd Font 11";
        frame_width = 2;
        frame_color = "#cba6f7";
        separator_color = "frame";
        highlight = "#cba6f7";
        corner_radius = 8;
        padding = 12;
        horizontal_padding = 12;
        gap_size = 6;
        offset = "12x12";
      };

      urgency_low = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        timeout = 4;
      };

      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        timeout = 8;
      };

      urgency_critical = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#fab387";
        timeout = 0;
      };
    };
  };
}
