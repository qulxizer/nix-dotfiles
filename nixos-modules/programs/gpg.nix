{ ... }: {
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true; # Optional: replaces ssh-agent with gpg-agent
    # pinentryPackage = "qt"; # Or "qt" / "curses" depending on your desktop environment
  };
}
