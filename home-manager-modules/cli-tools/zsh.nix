{ pkgs, config, ... }:
{
  home.file.".p10k.zsh".source = ../../non-home-manager/zsh/.p10k.zsh;
  programs.zsh = {
    enable = true;
    initContent = ''
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        {
          name = "romkatv/powerlevel10k";
          tags = [
            "as:theme"
            "depth:1"
          ];
        }
      ];
    };
  };
}
