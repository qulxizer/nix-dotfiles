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
    grim
    vesktop
    ags
    wofi
    fish
    alacritty
    gnome-font-viewer
    tree
    easyeffects
    inputs.swww.packages.${pkgs.system}.swww
    inputs.zen-browser.packages."${pkgs.system}".specific
    inputs.helix.packages."${pkgs.system}".helix
  ];
}
