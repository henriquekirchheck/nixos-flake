{ den, ... }:
{
  den.aspects.hardware.provides.networking.provides.network-manager = {
    includes = [
      den.aspects.hardware._.networking
      den.aspects.hardware._.networking._.network-manager._.permission
    ];
    nixos.networking.networkmanager = {
      enable = true;
      dns = "none";
    };
    provides.permission =
      { user, ... }:
      {
        nixos.users.users.${user.userName}.extraGroups = [ "networkmanager" ];
      };
  };
}
