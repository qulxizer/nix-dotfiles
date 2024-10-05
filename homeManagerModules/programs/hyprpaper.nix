{ ... }:
{
  services.hyprpaper.enable = true;
  services.hyprpaper.settings = {
    ipc = "on";
    splash = false;
    splash_offset = 2.0;

    preload =
      [ "~/.dotfiles/wallpapers/musashi.png" ];

    wallpaper = [
      "DP-3,~/.dotfiles/wallpapers/musashi.png"
    ];
  };
}
