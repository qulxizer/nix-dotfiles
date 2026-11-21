{ inputs, ... }: {
  # imports = [
  #   inputs.catppuccin.homeModules.catppuccin
  # ];

  catppuccin = {
    enable = true; # themes all your enabled supported apps automatically
    flavor = "mocha"; # latte, frappe, macchiato, or mocha
    accent = "mauve"; # optional accent color
  };

  # or override specific apps if you want
  # catppuccin.kitty.enable = false;
}
