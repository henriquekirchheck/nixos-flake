{ den, ... }:
{
  den.aspects.hardware.networking.network-manager = {
    includes = [ den.aspects.hardware.networking ];
    nixos.networking.networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };
    permission.user.extraGroups = [ "networkmanager" ];

    persist = _: { directories = [ "/etc/NetworkManager/system-connections" ]; };
  };
}
