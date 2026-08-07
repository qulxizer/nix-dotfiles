{ ... }: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        dpi-aware = "yes";
        font = "Iosevka NerdFont :size=16";
        term = "xterm-256color";
      };
      mouse = {
        hide-when-typing = "yes";
      };
    };

  };

}
