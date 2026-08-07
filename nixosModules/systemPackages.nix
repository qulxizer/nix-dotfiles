{ pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
	neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
	wget
	swaylock
	fuzzel
	mako
	swayidle
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
    alacritty
    gnome-font-viewer
    tree
    easyeffects
    # ags
    home-manager
    # magnetic-catppuccin-gtk
    nwg-look
    hyprpaper
    # haskellPackages.gi-dbusmenugtk3
    # inputs.swww.packages.${pkgs.system}.swww
    # inputs.zen-browser.packages."${pkgs.system}".specific
  ];
}
