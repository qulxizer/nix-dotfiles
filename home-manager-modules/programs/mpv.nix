{ pkgs, ... }:

let
  mpvHandler = pkgs.writeShellScriptBin "mpv-handler" ''
    raw="$1"

    url="''${raw#mpv://}"
    url="''${url#mpv:}"

    if [[ "$url" =~ ^(https?)//(.*) ]]; then
      url="''${BASH_REMATCH[1]}://''${BASH_REMATCH[2]}"
    fi

    exec ${pkgs.mpv}/bin/mpv "$url"
  '';
in
{
  home.packages = [ mpvHandler ];

  xdg.desktopEntries.mpv-handler = {
    name = "MPV URL Handler";
    exec = "${mpvHandler}/bin/mpv-handler %u";
    noDisplay = true;
    terminal = false;
    mimeType = [ "x-scheme-handler/mpv" ];
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/mpv" = [ "mpv-handler.desktop" ];
    };
    associations.added = {
      "x-scheme-handler/mpv" = [ "mpv-handler.desktop" ];
    };
  };

  programs.mpv = {
    enable = true;

    scripts = with pkgs.mpvScripts; [
      mpris
      thumbfast
    ];

    config = {
      profile = "gpu-hq";
      vo = "gpu";
      hwdec = "auto";
      osc = "no";
      cache = "yes";
    };

    bindings = {
      "WHEEL_UP" = "add volume 2";
      "WHEEL_DOWN" = "add volume -2";
      "SPACE" = "cycle pause";
    };
  };
}
