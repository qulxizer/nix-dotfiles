{ pkgs, ... }: {
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
