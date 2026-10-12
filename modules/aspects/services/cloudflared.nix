{ __findFile, lib, ... }:
{
  den.quirks = {
    cloudflared-tunnels.description = "Cloudflare Tunnels to be configured";
    cloudflared-ingress.description = "Cloudflare Tunnels Ingress to be configured";
  };
  den.aspects.services.cloudflared = {
    includes = [ <services/cloudflared/collectIngress> ];
    nixos.services.cloudflared.enable = true;
  };

  den.aspects.services.cloudflared.tunnel = name: {
    nixos =
      {
        host,
        lib,
        config,
        ...
      }:
      {
        services.cloudflared.tunnels.${name} = lib.mkIf (host.hasAspect <sops>) {
          certificateFile = config.sops.secrets."cloudflared/tunnel/${name}/cert".path;
          credentialsFile = config.sops.secrets."cloudflared/tunnel/${name}/cert".path;
          default = "http_status:404";
        };
      };
    secrets = _: [
      "cloudflared/tunnel/${name}/cert"
      "cloudflared/tunnel/${name}/credentials/account-tag"
      "cloudflared/tunnel/${name}/credentials/tunnel-secret"
      "cloudflared/tunnel/${name}/credentials/tunnel-id"
      "cloudflared/tunnel/${name}/credentials/endpoint"
    ];
  };

  den.aspects.services.cloudflared.collectIngress = {
    nixos = { cloudflared-ingress, lib, ... }: {
      # TODO: Setup ingress
      # services.caddy.virtualHosts = lib.mkMerge caddy-virtual-hosts;
    };
  };
}
