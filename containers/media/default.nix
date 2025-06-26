# Auto-generated using compose2nix v0.3.2-pre.
{
  pkgs,
  lib,
  config,
  ...
}:

{

  # Containers
  virtualisation.oci-containers.containers."media-bazarr" = {
    image = "ghcr.io/hotio/bazarr:latest";
    environment = {
      "PGID" = "100";
      "PUID" = "1000";
      "TZ" = "America/Sao_Paulo";
    };
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "/vol/drive/containers/media/appdata/bazarr:/config:rw"
      "/vol/drive/containers/media/data/media:/data/media:rw"
    ];
    ports = [
      "6767:6767/tcp"
    ];
    labels = {
      "io.containers.autoupdate" = "registry";
    };
    log-driver = "journald";
    extraOptions = [
      "--network-alias=bazarr"
      "--network=media_default"
    ];
  };
  systemd.services."podman-media-bazarr" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-media_default.service"
    ];
    requires = [
      "podman-network-media_default.service"
    ];
    partOf = [
      "podman-compose-media-root.target"
    ];
    wantedBy = [
      "podman-compose-media-root.target"
    ];
  };
  virtualisation.oci-containers.containers."media-flaresolverr" = {
    image = "ghcr.io/flaresolverr/flaresolverr:latest";
    environment = {
      "TZ" = "America/Sao_Paulo";
    };
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
    ];
    ports = [
      "8191:8191/tcp"
    ];
    labels = {
      "io.containers.autoupdate" = "registry";
    };
    log-driver = "journald";
    extraOptions = [
      "--network-alias=flaresolverr"
      "--network=media_default"
    ];
  };
  systemd.services."podman-media-flaresolverr" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-media_default.service"
    ];
    requires = [
      "podman-network-media_default.service"
    ];
    partOf = [
      "podman-compose-media-root.target"
    ];
    wantedBy = [
      "podman-compose-media-root.target"
    ];
  };
  virtualisation.oci-containers.containers."media-jellyfin" = {
    image = "ghcr.io/hotio/jellyfin:latest";
    environment = {
      "NVIDIA_DRIVER_CAPABILITIES" = "all";
      "NVIDIA_VISIBLE_DEVICES" = "all";
      "PGID" = "100";
      "PUID" = "1000";
      "TZ" = "America/Sao_Paulo";
    };
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "/vol/drive/containers/media/appdata/jellyfin:/config:rw"
      "/vol/drive/containers/media/data/media:/data/media:rw"
    ];
    ports = [
      "8096:8096/tcp"
    ];
    labels = {
      "io.containers.autoupdate" = "registry";
    };
    log-driver = "journald";
    extraOptions = [
      "--device=nvidia.com/gpu=all"
      "--network-alias=jellyfin"
      "--network=media_default"
      "--security-opt=label=disable"
    ];
  };
  systemd.services."podman-media-jellyfin" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-media_default.service"
    ];
    requires = [
      "podman-network-media_default.service"
    ];
    partOf = [
      "podman-compose-media-root.target"
    ];
    wantedBy = [
      "podman-compose-media-root.target"
    ];
  };
  virtualisation.oci-containers.containers."media-lidarr" = {
    image = "ghcr.io/hotio/lidarr:latest";
    environment = {
      "PGID" = "100";
      "PUID" = "1000";
      "TZ" = "America/Sao_Paulo";
    };
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "/vol/drive/containers/media/appdata/lidarr:/config:rw"
      "/vol/drive/containers/media/data:/data:rw"
    ];
    ports = [
      "8686:8686/tcp"
    ];
    labels = {
      "io.containers.autoupdate" = "registry";
    };
    log-driver = "journald";
    extraOptions = [
      "--network-alias=lidarr"
      "--network=media_default"
    ];
  };
  systemd.services."podman-media-lidarr" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-media_default.service"
    ];
    requires = [
      "podman-network-media_default.service"
    ];
    partOf = [
      "podman-compose-media-root.target"
    ];
    wantedBy = [
      "podman-compose-media-root.target"
    ];
  };
  virtualisation.oci-containers.containers."media-prowlarr" = {
    image = "ghcr.io/hotio/prowlarr:latest";
    environment = {
      "PGID" = "100";
      "PUID" = "1000";
      "TZ" = "America/Sao_Paulo";
    };
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "/vol/drive/containers/media/appdata/prowlarr:/config:rw"
    ];
    ports = [
      "9696:9696/tcp"
    ];
    labels = {
      "io.containers.autoupdate" = "registry";
    };
    log-driver = "journald";
    extraOptions = [
      "--network-alias=prowlarr"
      "--network=media_default"
    ];
  };
  systemd.services."podman-media-prowlarr" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-media_default.service"
    ];
    requires = [
      "podman-network-media_default.service"
    ];
    partOf = [
      "podman-compose-media-root.target"
    ];
    wantedBy = [
      "podman-compose-media-root.target"
    ];
  };
  virtualisation.oci-containers.containers."media-qbittorrent" = {
    image = "ghcr.io/hotio/qbittorrent:latest";
    environment = {
      "PGID" = "100";
      "PUID" = "1000";
      "TZ" = "America/Sao_Paulo";
      "WEBUI_PORTS" = "8112/tcp,8112/udp";
    };
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "/vol/drive/containers/media/appdata/qbittorrent:/config:rw"
      "/vol/drive/containers/media/data/torrents:/data/torrents:rw"
    ];
    ports = [
      "8112:8112/tcp"
    ];
    labels = {
      "io.containers.autoupdate" = "registry";
    };
    log-driver = "journald";
    extraOptions = [
      "--network-alias=qbittorrent"
      "--network=media_default"
    ];
  };
  systemd.services."podman-media-qbittorrent" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-media_default.service"
    ];
    requires = [
      "podman-network-media_default.service"
    ];
    partOf = [
      "podman-compose-media-root.target"
    ];
    wantedBy = [
      "podman-compose-media-root.target"
    ];
  };
  virtualisation.oci-containers.containers."media-radarr" = {
    image = "ghcr.io/hotio/radarr:latest";
    environment = {
      "PGID" = "100";
      "PUID" = "1000";
      "TZ" = "America/Sao_Paulo";
    };
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "/vol/drive/containers/media/appdata/radarr:/config:rw"
      "/vol/drive/containers/media/data:/data:rw"
    ];
    ports = [
      "7878:7878/tcp"
    ];
    labels = {
      "io.containers.autoupdate" = "registry";
    };
    log-driver = "journald";
    extraOptions = [
      "--network-alias=radarr"
      "--network=media_default"
    ];
  };
  systemd.services."podman-media-radarr" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-media_default.service"
    ];
    requires = [
      "podman-network-media_default.service"
    ];
    partOf = [
      "podman-compose-media-root.target"
    ];
    wantedBy = [
      "podman-compose-media-root.target"
    ];
  };
  virtualisation.oci-containers.containers."media-readarr" = {
    image = "ghcr.io/hotio/readarr:latest";
    environment = {
      "PGID" = "100";
      "PUID" = "1000";
      "TZ" = "America/Sao_Paulo";
    };
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "/vol/drive/containers/media/appdata/readarr:/config:rw"
      "/vol/drive/containers/media/data:/data:rw"
    ];
    ports = [
      "8787:8787/tcp"
    ];
    labels = {
      "io.containers.autoupdate" = "registry";
    };
    log-driver = "journald";
    extraOptions = [
      "--network-alias=readarr"
      "--network=media_default"
    ];
  };
  systemd.services."podman-media-readarr" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-media_default.service"
    ];
    requires = [
      "podman-network-media_default.service"
    ];
    partOf = [
      "podman-compose-media-root.target"
    ];
    wantedBy = [
      "podman-compose-media-root.target"
    ];
  };
  virtualisation.oci-containers.containers."media-sonarr" = {
    image = "ghcr.io/hotio/sonarr:latest";
    environment = {
      "PGID" = "100";
      "PUID" = "1000";
      "TZ" = "America/Sao_Paulo";
    };
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "/vol/drive/containers/media/appdata/sonarr:/config:rw"
      "/vol/drive/containers/media/data:/data:rw"
    ];
    ports = [
      "8989:8989/tcp"
    ];
    labels = {
      "io.containers.autoupdate" = "registry";
    };
    log-driver = "journald";
    extraOptions = [
      "--network-alias=sonarr"
      "--network=media_default"
    ];
  };
  systemd.services."podman-media-sonarr" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-media_default.service"
    ];
    requires = [
      "podman-network-media_default.service"
    ];
    partOf = [
      "podman-compose-media-root.target"
    ];
    wantedBy = [
      "podman-compose-media-root.target"
    ];
  };

  # Networks
  systemd.services."podman-network-media_default" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "podman network rm -f media_default";
    };
    script = ''
      podman network inspect media_default || podman network create media_default
    '';
    partOf = [ "podman-compose-media-root.target" ];
    wantedBy = [ "podman-compose-media-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."podman-compose-media-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
