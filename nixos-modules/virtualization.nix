{ pkgs, ... }: {
  users.users.mahdi = {
    extraGroups = [
      "docker"
      "libvirtd"
    ];
  };
  virtualisation.libvirtd.enable = true;
  # services.xserver.videoDrivers = [ "vmware" ];
  # virtualisation.vmware.guest.enable = true;
  programs.virt-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  virtualisation.vmware.host.enable = true;

  nixpkgs.overlays = [
    (final: prev: {
      linuxKernel = prev.linuxKernel // {
        packagesFor =
          kernel:
          (prev.linuxKernel.packagesFor kernel).extend (
            kself: ksuper: {
              vmware = ksuper.vmware.overrideAttrs (old: {
                postInstall = (old.postInstall or "") + ''
                  touch $out/lib/modules/${kself.kernel.modDirVersion}/misc/vmmon.ko.cer
                  touch $out/lib/modules/${kself.kernel.modDirVersion}/misc/vmnet.ko.cer
                '';
              });
            }
          );
      };
    })
  ];
}
