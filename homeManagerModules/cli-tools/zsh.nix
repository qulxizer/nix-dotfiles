{ pkgs, config, ... }:
{


  programs.zsh = {
    enable = true;
    enableCompletion = true;
    dotDir = ".dotfiles/nonHomeManager/zsh/";
    initExtra = "source nonHomeManager/zsh/.p10k.zsh";
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
      ];
    };
  };
}
