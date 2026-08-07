# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      # inputs.home-manager.nixosModules.home-manager
      ./hardware-configuration.nix
      ./../../nixosModules/audio.nix
      ./../../nixosModules/systemPackages.nix
      ./../../nixosModules/services.nix
      ./../../nixosModules/bootloader.nix
      # ./../../nixosModules/programs/hyprland.nix ./../../nixosModules/programs/ags.nix
    ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  networking.hostName = "mahdi";

  time.timeZone = "Asia/Bahrain";

  # home-manager = {
  #   extraSpecialArgs = { inherit inputs; };
  #   users = {
  #     mahdi = import ./home.nix;
  #   };
  # };


  services.xserver.xkb.layout = "us";
  services.printing.enable = true;
  programs.niri.enable = true;

  users.users.mahdi = {
    isNormalUser = true;
    initialPassword = "2812";
    extraGroups = [ "wheel" ];

  };

  nixpkgs.config.allowUnfree = true;
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

