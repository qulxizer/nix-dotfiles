{ ... }: {
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true; # Optional: replaces ssh-agent with gpg-agent
    pinentryFlavor = "gtk2"; # Or "qt" / "curses" depending on your desktop environment
  };
}
