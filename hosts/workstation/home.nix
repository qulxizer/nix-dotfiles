{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # ./../../homeManagerModules/programs/hyprland.nix
    ./../../home-manager-modules/cli-tools/git.nix
    ./../../home-manager-modules/cli-tools/github.nix
    # ./../../homeManagerModules/programs/hyprpaper.nix
    # ./../../homeManagerModules/programs/alacritty.nix
    ./../../home-manager-modules/cli-tools/zsh.nix
    ./../../home-manager-modules/programs/spicetify.nix
    ./../../home-manager-modules/programs/foot.nix
    ./../../home-manager-modules/programs/niri.nix
    ./../../home-manager-modules/programs/rofi.nix
    ./../../home-manager-modules/programs/easyeffect.nix
  ];
  nixpkgs.config.allowUnfree = true;
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

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

  home.stateVersion = "26.05";
}
