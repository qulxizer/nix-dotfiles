{ config, pkgs, ... }:

{
  imports =
    [
      ./../../homeManagerModules/programs/ags.nix
      ./../../homeManagerModules/programs/hyprland.nix
      ./../../homeManagerModules/cli-tools/git.nix
      ./../../homeManagerModules/programs/hyprpaper.nix
      ./../../homeManagerModules/programs/alacritty.nix
      ./../../homeManagerModules/cli-tools/zsh.nix


    ];

  home.username = "qulx";
  home.homeDirectory = "/home/qulx";

  home.packages = with pkgs; [
    git
  ];
  xdg.mimeApps = {
    enable = true;
    defaultApplications =
      let
        browser = "zen.desktop";
      in
      {
        "text/html" = "${browser}";
        "x-scheme-handler/http" = "${browser}";
        "x-scheme-handler/https" = "${browser}";
        "x-scheme-handler/about" = "${browser}";
        "x-scheme-handler/unknown" = "${browser}";
      };
  };


  home.stateVersion = "24.05";
}
