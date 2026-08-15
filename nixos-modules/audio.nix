{ ... }:
{
  # services.pipewire.enable = true;
  # services.pipewire.wireplumber.enable = true;
  # services.pipewire.wireplumber.extraConfig."disable-suspend" = {
  #   "alsa_monitor.rules" = {
  #     "apply_properties" = {
  #       "session.suspend-timeout-seconds" = 0;
  #     };
  #   };
  # };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    # pulse.enable = true;
  };
  services.pipewire.extraConfig.pipewire."92-low-latency" = {
    "context.properties" = {
      # "session.suspend-timeout-seconds" = 0;
      "default.clock.rate" = 44100;
      #"defautlt.allowed-rates" = [ 192000 48000 44100 ];
      "defautlt.allowed-rates" = [
        192000
        48000
        44100
      ];
      # "default.clock.quantum" = 32;
      "default.clock.min-quantum" = 512;
      "default.clock.max-quantum" = 8192;
      # "api.alsa.ignore-dB" = false;
      # "node.pause-on-idle" = false;
      # "api.alsa.start-delay" = 1024;
    };
  };

}
