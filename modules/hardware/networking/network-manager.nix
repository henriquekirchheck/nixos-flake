{ den, ... }:
{
  den.aspects.hardware.provides.networking.provides.network-manager = {
    includes = [
      den.aspects.hardware._.networking
      den.aspects.hardware._.networking._.systemd._.resolved
    ];
    nixos.networking.networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };
    provides.permission.user.extraGroups = [ "networkmanager" ];
  };
}
