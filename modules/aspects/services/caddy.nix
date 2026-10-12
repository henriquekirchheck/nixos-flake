{ __findFile, lib, ... }:
{
  den.quirks = {
    caddy-plugins.description = "Caddy Plugins to be added to the build";
    caddy-virtual-hosts.description = "Caddy Virtual Hosts to be configured";
  };
  den.aspects.services.caddy = {
    includes = [ <services/caddy/collectVirtualHosts> ];

    nixos = {
      services.caddy = {
        enable = true;
        openFirewall = true;
      };
    };

    persist = _: [
      "/var/lib/caddy"
    ];
  };

  den.aspects.services.caddy.cloudflare-dns = {
    includes = [ <services/caddy/collectPlugins> ];
    nixos =
      {
        host,
        config,
        lib,
        ...
      }:
      {
        services.caddy = lib.mkIf (host.hasAspect <sops>) {
          environmentFile = config.sops.templates."caddy.env".path;
          globalConfig = "acme_dns cloudflare {env.CF_API_TOKEN}";
        };
      };

    caddy-plugins = _: [ "github.com/caddy-dns/cloudflare@v0.2.4" ];
    secrets = _: [ "caddy/cloudflare/api-token" ];
    templates = { config, ... }: [
      {
        "caddy.env" = {
          content = ''CF_API_TOKEN="${config.sops.placeholder."caddy/cloudflare/api-token"}"'';
          owner = config.services.caddy.user;
          group = config.services.caddy.group;
        };
      }
    ];
  };

  den.aspects.services.caddy.collectPlugins = {
    settings.hash = lib.mkOption {
      description = "The final hash of all plugins used by caddy";
      default = lib.fakeHash;
      type = lib.types.str;
    };
    nixos =
      {
        host,
        caddy-plugins,
        lib,
        pkgs,
        ...
      }:
      {
        services.caddy.package = pkgs.caddy.withPlugins {
          plugins = lib.unique caddy-plugins;
          hash = host.settings.services.caddy.collectPlugins.hash;
        };
      };
  };

  den.aspects.services.caddy.collectVirtualHosts = {
    nixos = { caddy-virtual-hosts, lib, ... }: {
      services.caddy.virtualHosts = lib.mkMerge caddy-virtual-hosts;
    };
  };
}
