{ inputs, ... }: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  fileSystems."/mnt/nas" = {
    device = "//172.16.115.188/Thicc32";
    fsType = "cifs";
    options =
      let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,nofail";
      in
      [ "${automount_opts},credentials=smb-secrets" ];
  };
}
