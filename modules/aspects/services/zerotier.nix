{ lib, ... }:
{
  den.aspects.services.zerotier = {
    settings.autoJoinNetworks = lib.mkOption {
      description = "Networks for zerotier to automatically join";
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
    nixos = { host, ... }: {
      services.zerotierone = {
        enable = true;
        joinNetworks = host.settings.services.zerotier.autoJoinNetworks;
      };
    };

    persist = _: { directories = [ "/var/lib/zerotier-one" ]; };
  };
}
