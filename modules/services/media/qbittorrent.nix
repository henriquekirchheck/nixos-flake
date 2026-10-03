{
  den.aspects.services.provides.media.provides.qbittorrent = {
    nixos =
      {
        lib,
        pkgs,
        ...
      }:
      {
        services.qbittorrent = {
          enable = true;
          webuiPort = 8112;

          serverConfig = {
            LegalNotice.Accepted = true;
            Core = {
              AutoDeleteAddedTorrentFile = "IfAdded";
            };
            Application = {
              FileLogger = {
                Enabled = true;
                Path = "/var/logs/qBittorrent";
                Backup = false;
                DeleteOld = false;
              };
            };
            BitTorrent = {
              Session = {
                AddTorrentStopped = "false";
                BTProtocol = "TCP";
                MaxConnections = -1;
                MaxConnectionsPerTorrent = -1;
                MaxUploads = -1;
                MaxUploadsPerTorrent = -1;
                Preallocation = true;
                TorrentContentLayout = "Subfolder";
              };
            };
            Preferences = {
              General.Locale = "en";
              WebUI = {
                AlternativeUIEnabled = true;
                RootFolder = "${pkgs.vuetorrent}/share/vuetorrent";

                LocalHostAuth = true;
                HostHeaderValidation = true;

                Username = "lina";
                Password_PBKDF2 = "@ByteArray(d7kSywH0qcc+67e4R4xpvg==:Oi9rw/YS+AP1xcdD0Js1k68+4dlVL1MinpTduvnAHNH+1B76w762FgKGKwHOthiw1yhpWfagqkTajVWgGtNlNg==)";
              };
            };
          };
        };

        systemd.services.qbittorrent.serviceConfig = {
          LogsDirectory = "qBittorrent";
          PrivateTmp = lib.mkForce false;
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
                  to 127.0.0.1:${toString config.services.qbittorrent.webuiPort}

                  health_uri /api/v2/app/version
                  health_method GET
                  health_status 200
                }
              '';
            };
            services.qbittorrent.serverConfig.Preferences.WebUI.ServerDomains =
              lib.strings.concatStringsSep ";" hostnames;
          };
      };
    };
  };
}
