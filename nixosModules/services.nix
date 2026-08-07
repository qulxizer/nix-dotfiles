{ ... }: {

services.keyd = {
  enable = true;
  settings = {
    main = {
      # Add your device IDs here ('*' applies to all keyboards)
      ids = [ "*" ];
      # Define your custom key mappings in the main layer
      main = {
        # Example 1: Remap Caps Lock to Escape
        capslock = "esc";
        
        # Example 2: Remap Right Alt to Right Control
        rightalt = "rightcontrol";
      };
    };
  };
};
}
