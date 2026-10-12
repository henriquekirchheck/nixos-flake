{ den, ... }:
{
  den.aspects.apps.containers.podman = {
    includes = [ den.aspects.apps.containers ];
    nixos =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        virtualisation = {
          podman = {
            enable = true;
            dockerCompat = true;
            dockerSocket.enable = true;
            defaultNetwork.settings.dns_enabled = true;
            autoPrune.enable = true;
          };
          oci-containers.backend = "podman";
          containers.containersConf.settings.engine.compose_warning_logs = false;
        };

        networking.firewall.interfaces = lib.mkMerge [
          (lib.mkIf (config.networking.nftables.enable) { "podman*".allowedUDPPorts = [ 53 ]; })
          (lib.mkIf (!config.networking.nftables.enable) { "podman+".allowedUDPPorts = [ 53 ]; })
        ];

        environment.systemPackages = [ pkgs.podman-compose ];
      };
  };
}
