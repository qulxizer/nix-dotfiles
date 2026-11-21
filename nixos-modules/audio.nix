{ ... }:
{
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    extraConfig.pipewire."92-vm-audio" = {
      "context.properties" = {
        "default.clock.rate" = 44100;
        "default.clock.allowed-rates" = [
          44100
          48000
          96000
          192000
        ];
        "default.clock.quantum" = 1024;
        "default.clock.min-quantum" = 512;
        "default.clock.max-quantum" = 8192;
      };
    };

    wireplumber.extraConfig."99-alsa-headroom" = {
      "monitor.alsa.rules" = [
        {
          matches = [ { "node.name" = "~alsa_output.*"; } ];
          actions.update-props = {
            "api.alsa.headroom" = 1024;
            "session.suspend-timeout-seconds" = 0;
          };
        }
      ];
    };
  };
}
