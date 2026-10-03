{ den, ... }: {
  den.aspects.services.provides.media.provides.jellyfin = {
    nixos =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        services.jellyfin = {
          enable = true;
          package = pkgs.pkgsCuda.jellyfin;

          configDir = "/etc/jellyfin";
          dataDir = "/var/lib/jellyfin";
          logDir = "/var/log/jellyfin";
          cacheDir = "/var/cache/jellyfin";

          forceEncodingConfig = true;
          hardwareAcceleration = {
            enable = true;
            device = "/dev/dri/renderD128";
            type = lib.mkMerge [
              (lib.mkDefault "vaapi")
              (lib.mkIf config.hardware.nvidia.enabled "nvenc")
            ];
          };
          transcoding = {
            enableHardwareEncoding = true;
            enableSubtitleExtraction = true;
            enableToneMapping = false;
            deleteSegments = true;

            encodingPreset = "auto";
            h264Crf = 23;
            h265Crf = 28;
            hardwareDecodingCodecs = {
              vp8 = false;
              vp9 = true;
              av1 = false;
              h264 = true;
              hevc = true;
              hevc10bit = true;
              hevcRExt10bit = true;
              hevcRExt12bit = true;
              mpeg2 = true;
              vc1 = true;
            };
          };
        };
        systemd.services.jellyfin.serviceConfig.PrivateDevices = true;
        networking.firewall.allowedUDPPorts = [ 7359 ];
      };
    provides = {
      setupCaddy = hostnames: {
        description = "Caddy Reverse Proxy";
        nixos =
          { lib, ... }:
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
                reverse_proxy 127.0.0.1:8096 {
                  health_uri /health
                  health_method GET
                  health_status 200
                }
              '';
            };
          };
      };
      setupCloudflareTunnel = id: hostname: {
        description = "Setup Cloudflare Tunnel";
        includes = [
          (den.aspects.services._.cloudflared._.addIngress {
            inherit id;
            ingress.${hostname}.service = "http://localhost:8096";
          })
        ];
      };
    };
  };
}
