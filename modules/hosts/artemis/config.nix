{ __findFile, ... }:
{
  den.hosts.x86_64-linux.artemis = {
    hostName = "artemis";
    description = "Personal Computer that is also used as a server";

    users.lina.classes = [ "homeManager" ];

    settings = {
      hardware = {
        graphics.nvidia.legacy = true;
        networking.networkd.networks."10-wired" = {
          matchName = "enp*";
          address = [ "10.0.0.10/24" ];
          gateway = [
            "10.0.0.1"
            "fe80::"
          ];
        };
      };
      disk = {
        btrfs.device = "/dev/disk/by-id/nvme-ADATA_LEGEND_710_4P1322221261";
        drive = {
          cacheDevice = "/dev/disk/by-id/ata-KINGSTON_SA400S37120G_50026B738010441A";
          cacheSize = "100%";
          storageDevices = [ "/dev/disk/by-id/ata-ST1000DM010-2EP102_ZN109QYB" ];
          subvolumes = {
            "/servers".mountpoint = "/media/servers";
            "/steam".mountpoint = "/media/steam";
            "/games".mountpoint = "/media/games";
            "/storage".mountpoint = "/media/storage";
            "/recordings" = {
              mountpoint = "/media/recordings";
              mountOptions = [ "noatime" ];
            };
            "/arr" = {
              mountpoint = "/media/arr";
              mountOptions = [ "noatime" ];
            };
            "/arr/media" = {
              mountpoint = "/media/media";
              mountOptions = [ "noatime" ];
            };
            "/arr/torrents" = {
              mountpoint = "/media/torrents";
              mountOptions = [ "noatime" ];
            };
          };
        };
      };
      batteries = {
        locale = {
          default = "en_US.UTF-8";
          extra = "pt_BR.UTF-8";
        };
        peripheral = {
          outputs = {
            DVI-D-1 = {
              position = {
                x = 0;
                y = 0;
              };
              mode = {
                width = 1920;
                height = 1080;
              };
            };
            HDMI-A-1 = {
              position = {
                x = 1920;
                y = 0;
              };
              mode = {
                width = 1920;
                height = 1080;
              };
            };
          };
          xkb = {
            layout = "br";
            model = "abnt2";
            options = "caps:escape_shifted_capslock";
          };
        };
      };
      services.caddy.collectPlugins.hash = "sha256-xRJ5evsAJ2akg47j3Bt6YDXJOgX88B/rKNP50KSVyNY=";
    };
  };

  den.aspects.artemis = {
    includes = [
      <disk/btrfs>
      <disk/drive>

      <hardware/kernel/xanmod>
      <hardware/bootloader/systemd-boot>
      <hardware/graphics/nvidia>
      <hardware/audio/pipewire>
      <hardware/swap/zswap>
      <hardware/networking/networkd>

      <sops>
      (<sops/systemFile> ./secrets.yaml)

      (<batteries/facter> ./facter.json)

      <themes/catppuccin>

      <services/sshd>
      <services/zerotier>
      <services/postgres>
      <services/postgres/backup>

      <services/caddy>
      <services/caddy/cloudflare-dns>

      # <services/cloudflared>
      # (<services/cloudflared/tunnel> "artemis-lina")
      # (<services/cloudflared/tunnel> "artemis-henriquekh")

      <apps/nix>

      <apps/security/fail2ban>
      <apps/security/permission/sudo-rs>
      <apps/security/firewall>

      <apps/virtualisation/qemu>
      <apps/virtualisation/libvirtd>
      <apps/virtualisation/virt-manager>
      <apps/containers/podman>
      <apps/compatibility/wine>

      <apps/games/minecraft/server/ports>
    ];
  };
}
