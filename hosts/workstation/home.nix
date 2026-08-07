{ config, pkgs, ... }:

{
  imports = [
    # ./../../homeManagerModules/programs/hyprland.nix
    ./../../home-manager-modules/cli-tools/git.nix
    # ./../../homeManagerModules/programs/hyprpaper.nix
    # ./../../homeManagerModules/programs/alacritty.nix
    ./../../home-manager-modules/cli-tools/zsh.nix
    ./../../home-manager-modules/programs/spicetify.nix
  ];
  home-manager.useGlobalPkgs = true;

  home.username = "mahdi";
  home.homeDirectory = "/home/mahdi";
  home.enableNixpkgsReleaseCheck = false;

  # home.packages = with pkgs; [
  #   git
  # ];
  xdg.mimeApps = {
    enable = true;
    defaultApplications =
      let
        browser = "brave.desktop";
      in
      {
        "text/html" = "${browser}";
        "x-scheme-handler/http" = "${browser}";
        "x-scheme-handler/https" = "${browser}";
        "x-scheme-handler/about" = "${browser}";
        "x-scheme-handler/unknown" = "${browser}";
      };
  };

  home.stateVersion = "25.05";
}
