{ den, ... }:
{
  den.aspects.services.provides.vaultwarden =
    let
      address = "127.0.0.1";
      port = 8222;
    in
    {
      description = "Vaultwarden Password Manager";
      nixos = {
        services.vaultwarden = {
          enable = true;
          dbBackend = "postgresql";
          configurePostgres = true;
          config = {
            SIGNUPS_ALLOWED = false;

            ROCKET_ADDRESS = address;
            ROCKET_PORT = port;

            ROCKET_LOG = "critical";
          };
        };
      };
      provides = {
        includeEnvironment = sopsFile: {
          description = "Include secret as environment variable file";
          includes = [ den.aspects.apps._.sops ];
          nixos =
            { config, ... }:
            let
              secret = "vaultwarden_env";
            in
            {
              sops.secrets.${secret} = {
                inherit sopsFile;
                format = "dotenv";
                key = "";
              };
              services.vaultwarden.environmentFile = config.sops.secrets.${secret}.path;
            };
        };
        setupCaddy = domain: {
          description = "Setup Caddy reverse proxy";
          includes = [
            (den.aspects.services._.caddy._.addVirtualHost [ domain ] ''
              encode zstd gzip
              header / {
                Strict-Transport-Security "max-age=31536000;"
                X-XSS-Protection "0"
                X-Frame-Options "SAMEORIGIN"
                X-Robots-Tag "noindex, nofollow"
                X-Content-Type-Options "nosniff"
                -Last-Modified
              }
              reverse_proxy ${address}:${toString port} {
                header_up X-Real-IP {remote_host}
              }
            '')
          ];
          nixos.services.vaultwarden.domain = domain;
        };
        setupCloudflareTunnel = id: domain: {
          description = "Setup Cloudflare Tunnel";
          includes = [
            (den.aspects.services._.cloudflared._.addIngress {
              inherit id;
              ingress.${domain}.service = "http://${address}:${toString port}";
            })
          ];
          nixos.services.vaultwarden.domain = domain;
        };
      };
    };
}
