{ pkgs, ... }: {
  programs.xwayland.enable = true;
  environment.systemPackages = with pkgs; [
    xwayland-satellite
    SDL2
  ];
  hardware.steam-hardware.enable = true;
  hardware.uinput.enable = true;

  services.udev.packages = with pkgs; [
    game-devices-udev-rules
  ];
  # environment.systemPackages = pkgs.xwayland-satellite;
  programs.steam.enable = true;
}
