{ den, ... }:
{
  den.aspects.apps.containers.docker = {
    includes = [ den.aspects.apps.containers ];
    nixos =
      {
        config,
        lib,
        ...
      }:
      {
        virtualisation = {
          docker = {
            enable = true;
            enableOnBoot = true;
            autoPrune = true;
            storageDriver = lib.mkMerge [
              (lib.mkIf (config.fileSystems."/".fsType == "btrfs") "btrfs")
              (lib.mkIf (config.fileSystems."/".fsType != "btrfs") "overlay2")
            ];
          };
          oci-containers.backend = "docker";
        };
      };

    persist = _: { directories = [ "/var/lib/docker" ]; };

    permission.user.extraGroups = [ "docker" ];
  };
}
