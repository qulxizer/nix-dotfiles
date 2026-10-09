{ ... }: {
  users.users.mahdi = {
    extraGroups = [
      "docker"
      "libvirtd"
    ];
  };
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  programs.virt-manager.enable = true;
}
