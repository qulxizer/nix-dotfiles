{ pkgs, lib, ... }: {
  home.file.".p10k.zsh".source = ../../non-home-manager/zsh/.p10k.zsh;

  programs.zsh = {
    enable = true;

    # mkBefore forces this to the absolute top of .zshrc
    initContent = lib.mkBefore ''
      # Instant prompt
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

      # Source config variables
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };
}
