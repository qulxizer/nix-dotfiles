{ pkgs, ... }: {
  programs.chromium = {
    enable = false;
    package = pkgs.brave;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
    ];
    commandLineArgs = [
      "--enable-features=VaapiVideoDecoder,VaapiVideoEncoder,AcceleratedVideoDecodeLinuxGL,AcceleratedVideoEncoder"
      "--disable-features=UseChromeOSDirectVideoDecoder,WebRtcAllowInputVolumeAdjustment"
      "--ozone-platform-hint=auto"
      "--use-gl=angle"
      "--use-angle=vulkan"
    ];
  };
}
