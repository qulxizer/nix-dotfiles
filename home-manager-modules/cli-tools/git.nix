{ inputs, pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings.user.name = "mahdi";
    settings.user.email = "mahdi@1jz.cc";
  };
}
