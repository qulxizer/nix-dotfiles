{
  services.pipewire.extraConfig.pipewire."92-low-latency" = {
    "context.properties" = {
      "default.clock.rate" = 48000;
      #"defautlt.allowed-rates" = [ 192000 48000 44100 ];
      "defautlt.allowed-rates" = [ 48000 ];
      # "default.clock.quantum" = 32;
      # "default.clock.min-quantum" = 32;
      # "default.clock.max-quantum" = 32;
    };
  };

}
