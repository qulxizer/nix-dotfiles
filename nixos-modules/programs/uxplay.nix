{ config, pkgs, ... }:

{
  # Open network ports
  networking.firewall.allowedTCPPorts = [
    7000
    7001
    7100
  ];
  networking.firewall.allowedUDPPorts = [
    5353
    6000
    6001
    7011
  ];

  # To enable network-discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    settings = {
      server = {
        enable-dbus = true;
      };
      publish = {
        disable-publishing = false;
        disable-user-service-publishing = false;
        publish-addresses = true;
        publish-workstation = true;
        publish-domain = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    uxplay
  ];
}
