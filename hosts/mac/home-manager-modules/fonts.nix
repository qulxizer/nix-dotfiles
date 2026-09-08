{pkgs, ...}:{
  fonts.fontconfig.enable = true;

  # Add your font packages here
  home.packages = with pkgs; [
    nerd-fonts.iosevka
  ];
}
