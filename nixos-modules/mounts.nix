{ config, inputs, ... }:
let
  automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,nofail";
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops.secrets."nas/credentials" = { };

  users.groups.shared.gid = 3002;
  users.users.mahdi.extraGroups = [ "shared" ];

  fileSystems."/mnt/nas" = {
    device = "//172.16.115.188/Thicc32";
    fsType = "cifs";
    options = [
      "${automount_opts},credentials=${
        config.sops.secrets."nas/credentials".path
      },uid=1000,gid=1000,file_mode=0664,dir_mode=0775"
    ];
  };

  # 3. New NFS Mount
  fileSystems."/mnt/nas-nfs" = {
    device = "172.16.115.188:/mnt/Thicc32/Thicc32"; # Or add /downloads if you only exported sub-folders
    fsType = "nfs";
    options = [
      "${automount_opts},nfsvers=4,hard,rw"
    ];
  };
}
