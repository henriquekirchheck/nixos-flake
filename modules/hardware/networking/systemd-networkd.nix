{ den, ... }:
{
  den.aspects.hardware.provides.networking.provides.systemd.provides = {
    networkd = {
      includes = [
        den.aspects.hardware._.networking
        den.aspects.hardware._.networking._.systemd._.resolved
      ];
      nixos.systemd.network.enable = true;
      provides.static-config =
        {
          network ? "10-wired",
          matchName ? "enp*",
          address,
          gateway,
        }:
        {
          includes = [ den.aspects.hardware._.networking._.systemd._.networkd ];
          nixos.systemd.network = {
            networks = {
              ${network} = {
                matchConfig.Name = matchName;
                networkConfig = {
                  DHCP = "ipv6";
                  Address = [ address ];
                  Gateway = [ gateway ];

                  IPv6AcceptRA = true;
                  IPv6PrivacyExtensions = "prefer-public";

                  DNSSEC = true;
                  DNSOverTLS = true;
                  MulticastDNS = true;
                };
                dhcpV4Config.UseDNS = false;
                dhcpV6Config.UseDNS = false;
                ipv6AcceptRAConfig.UseDNS = false;
              };
            };
          };
        };
    };
    resolved = {
      includes = [ den.aspects.hardware._.networking ];
      nixos.services.resolved = {
        enable = true;
        settings.Resolve = {
          Domains = [ "~." ];
          DNSSEC = true;
          DNSOverTLS = true;
        };
      };
    };
  };
}
