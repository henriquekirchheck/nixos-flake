{ config, ... }:
{
  virtualisation.containers = {
    enable = true;
    containersConf.settings.engine.cdi_spec_dirs = [
      "/etc/cdi"
      "/run/cdi"
    ];
  };
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    defaultNetwork.settings.dns_enabled = true;
    autoPrune.enable = true;
  };
  networking.firewall.interfaces =
    let
      matchAll = if !config.networking.nftables.enable then "podman+" else "podman*";
    in
    {
      "${matchAll}".allowedUDPPorts = [ 53 ];
    };

  virtualisation.oci-containers.backend = "podman";
}
