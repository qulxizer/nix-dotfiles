{
  pkgs,
  config,
  lib,
  ...
}:
{
  home.file.".p10k.zsh".source = ../../non-home-manager/zsh/.p10k.zsh;

  programs.zsh = {
    enable = true;

    # Loads p10k instant prompt if you use it (optional but recommended)
    initExtraFirst = ''
      if [[ -r "\''${XDG_CACHE_HOME:-\$HOME/.cache}/p10k-instant-prompt-\''${(%):-%n}.zsh" ]]; then
        source "\''${XDG_CACHE_HOME:-\$HOME/.cache}/p10k-instant-prompt-\''${(%):-%n}.zsh"
      fi
    '';

    # Actually sources your config
    initExtra = ''
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };
}
