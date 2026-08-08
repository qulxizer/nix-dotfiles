{ config, ... }: {
  programs.rofi = {
    enable = true;
    font = "Iosevka Nerd Font 13";

    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
      terminal = "ghostty";
      drun-display-format = "{name}";
      disable-history = false;
      hide-scrollbar = true;
      display-drun = " ";
      display-run = " ";
      display-window = "󰕰 ";
      display-dmenu = "📋 ";
    };

    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        "*" = {
          bg = mkLiteral "#1e1e2ef2"; # f2 gives it that subtle transparency if you run a compositor
          bg-alt = mkLiteral "#313244";
          fg = mkLiteral "#cdd6f4";
          fg-alt = mkLiteral "#6c7086";
          accent = mkLiteral "#cba6f7";

          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@fg";
          margin = mkLiteral "0";
          padding = mkLiteral "0";
          spacing = mkLiteral "0";
        };

        "window" = {
          background-color = mkLiteral "@bg";
          border = mkLiteral "2px";
          border-color = mkLiteral "@accent";
          border-radius = mkLiteral "16px";
          width = mkLiteral "700px";
          padding = mkLiteral "24px";
        };

        "inputbar" = {
          spacing = mkLiteral "12px";
          padding = mkLiteral "16px 24px";
          background-color = mkLiteral "@bg-alt";
          border-radius = mkLiteral "12px";
          children = mkLiteral "[ prompt, entry ]";
        };

        "prompt" = {
          text-color = mkLiteral "@accent";
          vertical-align = mkLiteral "0.5";
        };

        "entry" = {
          placeholder = "Search...";
          placeholder-color = mkLiteral "@fg-alt";
          text-color = mkLiteral "@fg";
          vertical-align = mkLiteral "0.5";
        };

        "listview" = {
          columns = mkLiteral "2";
          lines = mkLiteral "8";
          spacing = mkLiteral "12px";
          padding = mkLiteral "24px 0px 0px 0px";
          fixed-height = mkLiteral "true";
          fixed-columns = mkLiteral "true";
        };

        "element" = {
          padding = mkLiteral "12px 16px";
          border-radius = mkLiteral "10px";
          spacing = mkLiteral "16px";
          children = mkLiteral "[ element-icon, element-text ]";
        };

        "element-icon" = {
          size = mkLiteral "2.5em";
        };

        "element-text" = {
          vertical-align = mkLiteral "0.5";
          text-color = mkLiteral "inherit";
        };

        "element selected.normal" = {
          background-color = mkLiteral "@accent";
          text-color = mkLiteral "#1e1e2e"; # Dark text on light accent
        };
      };
  };
}
