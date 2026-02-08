{ den, ... }:
{
  den.aspects.apps.provides.containers = {
    description = "Containers";

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
        includes = [
          den.aspects.apps._.containers
          # TODO: Fix when https://github.com/vic/den/issues/145 resolved
          # den.aspects.apps._.containers._.docker._.permission
        ];
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
        provides.permission =
          { user, ... }:
          {
            nixos.users.users.${user.userName}.extraGroups = [ "libvirtd" ];
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
    };
  };
}
