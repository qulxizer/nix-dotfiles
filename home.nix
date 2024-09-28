
{ config, pkgs, ... }:

{

  home.username = "qulx";
  home.homeDirectory = "/home/qulx";


  home.packages = with pkgs; [
   git

  ];
  xdg.mimeApps = {
     enable = true;
     defaultApplications = let
        browser = "zen.desktop";
     in {
      "text/html" = "${browser}";
      "x-scheme-handler/http" = "${browser}";
      "x-scheme-handler/https" = "${browser}";
      "x-scheme-handler/about" = "${browser}";
      "x-scheme-handler/unknown" = "${browser}";
    };
  };

  programs.git = {
    enable = true;
    userName = "Qulx";
    userEmail = "qulxizer@gmail.com";
  };



  home.stateVersion = "24.05";
}
