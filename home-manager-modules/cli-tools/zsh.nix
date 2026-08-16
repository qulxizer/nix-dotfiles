{ pkgs, lib, ... }: {
  home.file.".p10k.zsh".source = ../../non-home-manager/zsh/.p10k.zsh;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # mkBefore forces this to the absolute top of .zshrc
    initContent = lib.mkBefore ''
      bindkey '^[[1;5D' backward-word
      bindkey '^[[1;5C' forward-word
      # Instant prompt
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

      # Source config variables
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
    shellAliases = {
      ll = "ls -l";
      update = "home-manager switch --flake .$USER";
    };

    history = {
      size = 10000;
      save = 10000;
    };
  };
}
