{ pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    catppuccin-gtk
    adwaita-icon-theme
    bibata-cursors
    vim
    git
    wget
    kitty
    firefox
    emacs
    vlc
    vscode
    nixpkgs-fmt
    grimblast
    vesktop
    cliphist
    wl-clipboard
    wofi
    fish
    alacritty
    gnome-font-viewer
    tree
    easyeffects
    ags
    home-manager
    magnetic-catppuccin-gtk
    nwg-look
    hyprpaper
    haskellPackages.gi-dbusmenugtk3
    inputs.swww.packages.${pkgs.system}.swww
    inputs.zen-browser.packages."${pkgs.system}".specific
  ];
}
