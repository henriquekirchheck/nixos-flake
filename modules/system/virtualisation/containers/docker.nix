{ config }:
{
  imports = [ ./base.nix ];
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
    storageDriver = if config.fileSystems."/".fsType == "btrfs" then "btrfs" else "overlay2";
  };
  virtualisation.oci-containers.backend = "docker";
}
