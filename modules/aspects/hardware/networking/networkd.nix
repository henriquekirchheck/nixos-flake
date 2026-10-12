{ den, lib, ... }:
{
  den.aspects.hardware.networking.networkd = {
    settings.networks = lib.mkOption {
      description = "Define networks for networkd to manage statically";
      type = lib.types.attrsOf (
        lib.types.submodule {
          options = {
            matchName = lib.mkOption {
              description = "Match for the network interface name";
              type = lib.types.str;
            };
            address = lib.mkOption {
              description = "The static IP addresses for this interface";
              type = lib.types.listOf lib.types.str;
            };
            gateway = lib.mkOption {
              description = "The gateway IP addresses for this interface";
              type = lib.types.listOf lib.types.str;
            };
          };
        }
      );
    };

    includes = [ den.aspects.hardware.networking ];
    nixos = { host, ... }: {
      systemd.network = {
        enable = true;
        networks = lib.mapAttrs (_: v: {
          matchConfig.Name = v.matchName;
          networkConfig = {
            DHCP = "ipv6";
            Address = v.address;
            Gateway = v.gateway;

            IPv6AcceptRA = true;
            IPv6PrivacyExtensions = "prefer-public";

            DNSSEC = true;
            DNSOverTLS = true;
            MulticastDNS = true;
          };
          dhcpV4Config.UseDNS = false;
          dhcpV6Config.UseDNS = false;
          ipv6AcceptRAConfig.UseDNS = false;
        }) host.settings.hardware.networking.networkd.networks;
      };
    };
    persist = _: {
      directories = [ "/var/lib/systemd/network" ];
    };
  };
}
