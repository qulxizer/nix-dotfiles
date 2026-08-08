{ pkgs, ... }: {
  programs.xwayland.enable = true;
  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ];
  # environment.systemPackages = pkgs.xwayland-satellite;
  programs.steam.enable = true;
}
