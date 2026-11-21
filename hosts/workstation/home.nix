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
    ./../../home-manager-modules/cli-tools/tmux.nix
    ./../../home-manager-modules/cli-tools/github.nix
    # ./../../homeManagerModules/programs/hyprpaper.nix
    # ./../../homeManagerModules/programs/alacritty.nix
    ./../../home-manager-modules/cli-tools/zsh.nix
    ./../../home-manager-modules/cli-tools/yazi.nix
    ./../../home-manager-modules/programs/spicetify.nix
    # ./../../home-manager-modules/programs/mpv.nix
    ./../../home-manager-modules/programs/foot.nix
    ./../../home-manager-modules/programs/niri.nix
    ./../../home-manager-modules/programs/sway.nix
    ./../../home-manager-modules/programs/catppuccin.nix
    ./../../home-manager-modules/programs/rofi.nix
    ./../../home-manager-modules/programs/dunst.nix
    ./../../home-manager-modules/programs/easyeffect.nix
  ];
  nixpkgs.config.allowUnfree = true;
  home.sessionVariables = {
    GDK_PIXBUF_MODULE_FILE = "${pkgs.librsvg}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache";
    NIXOS_OZONE_WL = "1";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.username = "mahdi";
  home.homeDirectory = "/home/mahdi";
  home.enableNixpkgsReleaseCheck = false;

  home.packages = with pkgs; [
    grim
    librsvg
    slurp
  ];
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  qt = {
    enable = true;
    style = {
      name = "kvantum";
    };
  };

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
