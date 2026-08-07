{ ... }: {
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true; # Optional: replaces ssh-agent with gpg-agent
    pinentryPackage = "curses"; # Or "qt" / "curses" depending on your desktop environment
  };
}
