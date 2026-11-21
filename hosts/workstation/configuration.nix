# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # inputs.sops-nix.nixosModules.sops
    # inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    ./../../nixos-modules/audio.nix
    ./../../nixos-modules/virtualization.nix
    ./../../nixos-modules/programs/flatpak.nix
    ./../../nixos-modules/programs/bedrock.nix
    ./../../nixos-modules/system-packages.nix
    ./../../nixos-modules/services.nix
    ./../../nixos-modules/bootloader.nix
    ./../../nixos-modules/programs/gpg.nix
    ./../../nixos-modules/programs/steam.nix
    ./../../nixos-modules/programs/uxplay.nix
    ./../../nixos-modules/programs/warp.nix
    ./../../nixos-modules/mounts.nix
    ./../../nixos-modules/programs/prism.nix
    # ./../../nixosModules/programs/hyprland.nix ./../../nixosModules/programs/ags.nix
  ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  nixpkgs.config.allowUnfree = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings = {
    bip = "10.200.0.1/16";
    default-address-pools = [
      {
        base = "10.201.0.0/16";
        size = 24;
      }
    ];
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  networking.hostName = "mahdi";
  networking.hosts = {
    "172.16.235.98" = [ "git.1jz.cc" ];
  };

  networking.firewall = {
    enable = false;
    allowedTCPPorts = [
      3001
    ];
    allowedUDPPorts = [ 51820 ];
    allowedTCPPortRanges = [
      {
        from = 3000;
        to = 3010;
      }
    ];
  };

  time.timeZone = "Asia/Bahrain";

  # Secrets
  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/mahdi/.config/sops/age/keys.txt";

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "backup";
    users = {
      mahdi = import ./home.nix;
    };
  };
  networking.networkmanager.enable = true;

  services.xserver.xkb.layout = "us";
  services.printing.enable = true;
  security.polkit = {
    enable = true;
    enablePkexecWrapper = true;
  };
  programs.niri.enable = true;
  programs.sway.enable = true;
  programs.dconf.enable = true;
  programs.zsh.enable = true;
  users.users.mahdi = {
    isNormalUser = true;
    initialPassword = "2812";
    extraGroups = [
      "wheel"
      "dialout"
      "docker"
    ];
    shell = pkgs.zsh;

  };

  fonts.packages = with pkgs; [
    # noto-fonts
    nerd-fonts.iosevka
    # noto-fonts-cjk
    # noto-fonts-emoji
    # liberation_ttf
    # fira-code
    # fira-code-symbols
    # dina-font
    # proggyfonts
    # corefonts
    # vistafonts
    # (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
  #
  # fonts.fontconfig.defaultFonts =
  #   {
  #     serif = [ "Liberation Serif" "Noto Naskh Arabic" ];
  #     sansSerif = [ "Noto Sans" "Noto Naskh Arabic" ];
  #     monospace = [ "Fira Code" ];
  #   };

  services.openssh.enable = true;
  system.stateVersion = "26.05"; # Did you read the comment? No.

}
