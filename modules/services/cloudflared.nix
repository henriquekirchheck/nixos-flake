{ den, ... }:
{
  den.aspects.services.provides.cloudflared = {
    description = "Cloudflare Daemon for Tunnels";

    nixos.services.cloudflared.enable = true;

    provides = {
      addTunnel =
        {
          id,
          sopsFile,
        }:
        let
          secret = "cloudflare_tunnel-${id}";
        in
        {
          description = "Add new tunnel to cloudflared using a secret";
          includes = [ den.aspects.apps._.sops ];
          nixos =
            { config, ... }:
            {
              sops.secrets.${secret} = {
                sopsFile = sopsFile;
                format = "json";
                key = "";
              };
              services.cloudflared.tunnels = {
                ${id} = {
                  credentialsFile = config.sops.secrets.${secret}.path;
                  default = "http_status:404";
                };
              };
            };
        };
      addIngress =
        {
          id,
          ingress,
        }:
        {
          description = "Add new ingress definition to existing tunnel";
          nixos.services.cloudflared.tunnels.${id}.ingress = ingress;
        };
    };
  };
}
