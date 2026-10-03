{
  den.aspects.services.provides.media.provides.prowlarr = {
    nixos =
      {
        config,
        lib,
        ...
      }:
      {
        services.prowlarr = {
          enable = true;
          settings = {
            log.analyticsEnabled = false;
            update = {
              automatically = false;
              mechanism = "external";
            };
            server = {
              bindAddress = "*";
              port = 7878;
            };
            auth = {
              enabled = true;
              method = "Forms";
              required = true;
            };
            postgres = lib.mkIf config.services.postgresql.enable {
              mainDB = "prowlarr";
              logDB = "prowlarr";
              user = "prowlarr";
              host = "/run/postgresql";
            };
          };
        };
        services.postgresql = lib.mkIf config.services.postgresql.enable {
          ensureDatabases = [ "prowlarr" ];
          ensureUsers = [
            {
              name = "prowlarr";
              ensureDBOwnership = true;
            }
          ];
        };
        systemd.services.prowlarr = {
          after = lib.mkIf config.services.postgresql.enable [ "postgresql.target" ];
          requires = lib.mkIf config.services.postgresql.enable [ "postgresql.target" ];
        };
      };

    provides = {
      setupCaddy = hostnames: {
        description = "Caddy Reverse Proxy";
        nixos =
          { config, lib, ... }:
          {
            services.caddy.virtualHosts.${builtins.elemAt hostnames 0} = {
              serverAliases = lib.sublist 1 ((lib.length hostnames) - 1) hostnames;
              extraConfig = ''
                encode zstd gzip
                header / {
                  Strict-Transport-Security "max-age=31536000;"
                  X-XSS-Protection "0"
                  X-Frame-Options "SAMEORIGIN"
                  X-Robots-Tag "noindex, nofollow"
                  X-Content-Type-Options "nosniff"
                }
                reverse_proxy / {
                  to 127.0.0.1:${toString config.services.prowlarr.settings.server.port}

                  health_uri /api/v2/app/version
                  health_method GET
                  health_status 200
                }
              '';
            };
            services.prowlarr.settings.server.allowedHosts = lib.strings.concatStringsSep "," hostnames;
          };
      };
    };
  };
}
