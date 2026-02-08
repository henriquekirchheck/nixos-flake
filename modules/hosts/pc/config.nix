{ den, ... }:
let
  otherDiskName = "other";
in
{
  den.aspects.pc = {
    includes = [
      (den.aspects.utils._.host._.locale {
        default = "en_US.UTF-8";
        extra = "pt_BR.UTF-8";
      })

      (den.aspects.utils._.disk._.createDisk {
        name = otherDiskName;
        device = "/dev/disk/by-id/ata-KINGSTON_SA400S37120G_50026B738010441A";
      })

      den.aspects.apps._.sops

      (den.aspects.hardware._.networking._.systemd._.networkd._.static-config {
        address = "10.0.0.10/24";
        gateway = "10.0.0.1";
      })

      den.aspects.services._.zerotier

      den.aspects.system._.bootloader._.systemd-boot
      den.aspects.system._.kernel._.cachy._.stable-v3
      den.aspects.system._.oom._.systemd-oomd

      (den.aspects.system._.impermanence._.addPersistance "/persist")
      (den.aspects.system._.impermanence._.setupBtrfs { partlabel = "disk-system-nixos"; })
      (den.aspects.system._.impermanence._.addOptions "/persist" {
        directories = [
          "/var/lib/bluetooth"
          "/var/lib/zerotier-one"
          "/var/lib/nixos"
          "/var/lib/docker"
          "/var/lib/containers"
          "/var/lib/systemd/coredump"
          "/var/lib/systemd/timers"
          "/etc/NetworkManager/system-connections"
          {
            directory = "/var/lib/caddy";
            user = "caddy";
            group = "caddy";
            mode = "u=rwx,g=rx,o=rx";
          }
        ];
        files = [
          "/etc/machine-id"
          "/etc/ssh/ssh_host_ed25519_key"
          "/etc/ssh/ssh_host_ed25519_key.pub"
          "/etc/ssh/ssh_host_rsa_key"
          "/etc/ssh/ssh_host_rsa_key.pub"
        ];
      })

      den.aspects.apps._.containers._.podman

      (den.aspects.services._.caddy._.withPlugins {
        plugins = [ "github.com/caddy-dns/cloudflare@v0.2.2" ];
        hash = "sha256-dnhEjopeA0UiI+XVYHYpsjcEI6Y1Hacbi28hVKYQURg=";
      })
      (den.aspects.services._.caddy._.includeEnvironment ./secrets/caddy.env)
      (den.aspects.services._.caddy._.includeGlobal ''
        acme_dns cloudflare {$CLOUDFLARE_API}
      '')

      den.aspects.services._.cloudflared
      (den.aspects.services._.cloudflared._.addTunnel {
        id = "52ba507f-2e7c-4527-9010-aaa4ff579fa2";
        sopsFile = ./secrets/tunnel-52ba507f-2e7c-4527-9010-aaa4ff579fa2.json;
      })

      (den.aspects.services._.ddclient {
        protocol = "cloudflare";
        domains = [ "henriquekh.dev.br" ];
        zone = "henriquekh.dev.br";
        sopsFile = ./secrets/ddclient.yaml;
      })

      (den.aspects.services._.forgejo-runner._.addInstance {
        name = "henrique-pc";
        url = "https://codeberg.org";
        sopsFile = ./secrets/forgejo-runner.env;
      })
      (den.aspects.utils._.disk._.addSubvolume {
        name = otherDiskName;
        subvolume = "forgejo-runner";
        mountpoint = "/var/lib/private/gitea-runner";
      })
    ];

    disko.disko.devices.disk = {
      system = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-ADATA_LEGEND_710_4P1322221261";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                extraArgs = [
                  "-n"
                  "boot"
                ];
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            nixos = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [
                  "-L"
                  "nixos"
                  "-f"
                ];
                subvolumes = {
                  "/root" = {
                    mountpoint = "/";
                    mountOptions = [
                      "subvol=root"
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "/home" = {
                    mountpoint = "/home";
                    mountOptions = [
                      "subvol=home"
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "subvol=nix"
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "/persist" = {
                    mountpoint = "/persist";
                    mountOptions = [
                      "subvol=persist"
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "/log" = {
                    mountpoint = "/var/log";
                    mountOptions = [
                      "subvol=log"
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "/swap" = {
                    mountpoint = "/swap";
                    swap.swapfile.size = "8G";
                  };
                };
              };
            };
          };
        };
      };
    };
    nixos = {
      fileSystems = {
        "/persist".neededForBoot = true;
        "/var/log".neededForBoot = true;
        "/vol/drive" = {
          device = "/dev/disk/by-uuid/f2c7fa52-5b47-46e9-b95c-4c467175cdce";
          fsType = "ext4";
        };
      };
    };
  };
}
