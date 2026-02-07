{ den, ... }:
{
  den.aspects.apps.provides.containers = {
    description = "Containers";

    includes = [ den.aspects.apps._.containers._.permission ];

    nixos =
      { pkgs, ... }:
      {
        virtualisation.containers = {
          enable = true;
          registries.search = [
            "quay.io"
            "docker.io"
          ];
        };
        environment.systemPackages = [ pkgs.compose2nix ];
      };

    provides = {
      docker = {
        includes = [ den.aspects.apps._.containers ];
        nixos =
          { config, ... }:
          {
            virtualisation = {
              docker = {
                enable = true;
                enableOnBoot = true;
                autoPrune.enable = true;
                storageDriver = if config.fileSystems."/".fsType == "btrfs" then "btrfs" else "overlay2";
              };
              oci-containers.backend = "docker";
            };
          };
      };
      podman = {
        includes = [ den.aspects.apps._.containers ];
        nixos =
          { config, pkgs, ... }:
          {
            virtualisation.podman = {
              enable = true;
              dockerCompat = true;
              dockerSocket.enable = true;
              defaultNetwork.settings.dns_enabled = true;
              autoPrune.enable = true;
            };
            virtualisation.oci-containers.backend = "podman";

            networking.firewall.interfaces =
              let
                matchAll = if !config.networking.nftables.enable then "podman+" else "podman*";
              in
              {
                "${matchAll}".allowedUDPPorts = [ 53 ];
              };

            environment.systemPackages = [ pkgs.podman-compose ];
          };
      };

      permission =
        { user, ... }:
        {
          nixos.users.users.${user.userName}.extraGroups = [ "libvirtd" ];
        };
    };
  };
}
