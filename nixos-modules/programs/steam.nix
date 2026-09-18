{ pkgs, ... }: {
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
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
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
