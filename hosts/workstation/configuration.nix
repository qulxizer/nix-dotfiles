# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./../../nixosModules/audio.nix
      ./../../nixosModules/hyprland.nix
      ./../../nixosModules/systemPackages.nix
      ./../../nixosModules/bootloader.nix
    ];


  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  networking.hostName = "qulx-pc";

  time.timeZone = "Asia/Bahrain";




  services.xserver.xkb.layout = "us";

  services.printing.enable = true;

  users.users.qulx = {
    isNormalUser = true;
    initialPassword = "2812";
    extraGroups = [ "wheel" ];
  };

  nixpkgs.config.allowUnfree = true;


  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    dina-font
    proggyfonts
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
  services.openssh.enable = true;
  system.stateVersion = "24.11"; # Did you read the comment? No.

}

