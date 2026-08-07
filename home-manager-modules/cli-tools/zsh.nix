{ pkgs, lib, ... }: {
  home.file.".p10k.zsh".source = ../../non-home-manager/zsh/.p10k.zsh;

  programs.zsh = {
    enable = true;

    # Actually load the theme engine
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    # Modern way to init in HM, fixes your warnings
    initContent = lib.mkMerge [
      (lib.mkBefore ''
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
      '')
      ''
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      ''
    ];
  };
}
