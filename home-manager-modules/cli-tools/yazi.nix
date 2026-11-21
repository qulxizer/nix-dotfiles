{ pkgs, ... }: {
  programs.yazi = {
    enable = true;
    plugins = with pkgs.yaziPlugins; {
      smart-enter.package = smart-enter;
      chmod.package = chmod;
      yatline-catppuccin.package = yatline-catppuccin;
      sudo.package = sudo;
    };

  };
}
