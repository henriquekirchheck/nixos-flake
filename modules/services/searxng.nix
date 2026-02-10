{ den, ... }:
{
  den.aspects.services.provides.searxng =
    let
      address = "127.0.0.1";
      port = 5947;
    in
    {
      description = "SearXNG";
      nixos =
        { pkgs, ... }:
        {
          services.searx = {
            enable = true;
            settings = {
              server = {
                image_proxy = true;
                inherit port;
                bind_address = address;
                secret_key = "$SEARXNG_SECRET_KEY";
              };
            };
            redisCreateLocally = true;
          };
          services.redis.package = pkgs.valkey;
        };
      provides = {
        includeEnvironment = sopsFile: {
          description = "Include secret as environment variable file";
          includes = [ den.aspects.apps._.sops ];
          nixos =
            { config, ... }:
            let
              secret = "searxng_env";
            in
            {
              sops.secrets.${secret} = {
                inherit sopsFile;
                format = "dotenv";
                key = "";
              };
              services.searx.environmentFile = config.sops.secrets.${secret}.path;
            };
        };
        setupCaddy = domain: {
          description = "Setup Caddy reverse proxy";
          includes = [
            (den.aspects.services._.caddy._.addVirtualHost [ domain ] ''
              encode zstd gzip
              reverse_proxy ${address}:${toString port}
            '')
          ];
          nixos.services.searx = {
            inherit domain;
            settings.server.base_url = domain;
          };
        };
        setupCloudflareTunnel = id: domain: {
          description = "Setup Cloudflare Tunnel";
          includes = [
            (den.aspects.services._.cloudflared._.addIngress {
              inherit id;
              ingress.${domain}.service = "http://${address}:${toString port}";
            })
          ];
          nixos.services.searx = {
            inherit domain;
            settings.server.base_url = domain;
          };
        };
      };
    };
}
