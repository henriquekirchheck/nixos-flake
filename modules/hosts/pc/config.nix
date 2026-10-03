{ den, ... }:
let
  mediaDomain = service: [
    "${service}.localhost"
    "${service}.zt.henriquekh.dev.br"
    "${service}.henriquekh.dev.br"
  ];
in
{
  den.aspects.pc = {
    includes = [
      (den.aspects.utils._.host._.locale {
        default = "en_US.UTF-8";
        extra = "pt_BR.UTF-8";
      })

      (den.aspects.utils._.disk._.createDisk {
        name = "drive";
        device = "/dev/disk/by-id/ata-ST1000DM010-2EP102_ZN109QYB";
      })
      (den.aspects.utils._.disk._.createDisk {
        name = "ssd";
        device = "/dev/disk/by-id/ata-KINGSTON_SA400S37120G_50026B738010441A";
      })

      den.aspects.apps._.sops
      den.aspects.apps._.nix
      den.aspects.apps._.nix-ld

      (den.aspects.hardware._.networking._.systemd._.networkd._.static-config {
        address = "10.0.0.10/24";
        gateway = "10.0.0.1";
      })
      den.aspects.hardware._.audio._.pipewire
      den.aspects.hardware._.graphics._.nvidia

      den.aspects.services._.zerotier
      den.aspects.services._.ssh._.server

      den.aspects.system._.bootloader._.systemd-boot
      den.aspects.system._.kernel._.xanmod
      den.aspects.system._.oom._.systemd-oomd
      den.aspects.system._.swap
      den.aspects.system._.swap._.zswap

      den.aspects.apps._.games._.minecraft._.server._.setup-ports

      (den.aspects.system._.impermanence._.addPersistance "/persist")
      (den.aspects.system._.impermanence._.setupBtrfs { partlabel = "disk-system-nixos"; })
      (den.aspects.system._.impermanence._.addOptions "/persist" {
        directories = [
          "/var/lib/bluetooth"
          "/var/lib/zerotier-one"
          "/var/lib/nixos"
          "/var/lib/docker"
          "/var/lib/containers"
          "/var/lib/postgresql"
          "/var/lib/vaultwarden"
          "/var/lib/fail2ban"
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
      den.aspects.apps._.virtualisation._.qemu
      den.aspects.apps._.virtualisation._.virt-manager

      (den.aspects.services._.caddy._.withPlugins {
        plugins = [ "github.com/caddy-dns/cloudflare@v0.2.2" ];
        hash = "sha256-xAw+kBA+rdhzABdogwNCo9zEtNMPG7zj5rgPpFxvpDo=";
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

      den.aspects.services._.vaultwarden
      (den.aspects.services._.vaultwarden._.includeEnvironment ./secrets/vaultwarden.env)
      (den.aspects.services._.vaultwarden._.setupCloudflareTunnel "52ba507f-2e7c-4527-9010-aaa4ff579fa2" "vault.henriquekh.dev.br")

      (den.aspects.services._.bitwarden-sync ./secrets/bitwarden-sync.env)

      den.aspects.services._.searxng
      (den.aspects.services._.searxng._.includeEnvironment ./secrets/searxng.env)
      (den.aspects.services._.searxng._.setupCloudflareTunnel "52ba507f-2e7c-4527-9010-aaa4ff579fa2" "search.henriquekh.dev.br")

     #den.aspects.services._.media._.jellyfin
     #(den.aspects.services._.media._.jellyfin._.setupCaddy (mediaDomain "jelly"))
     #(den.aspects.services._.media._.jellyfin._.setupCloudflareTunnel "52ba507f-2e7c-4527-9010-aaa4ff579fa2" "jelly.henriquekh.dev.br")
     #den.aspects.services._.media._.qbittorrent
     #(den.aspects.services._.media._.qbittorrent._.setupCaddy (mediaDomain "qbit"))
     #den.aspects.services._.media._.prowlarr
     #(den.aspects.services._.media._.prowlarr._.setupCaddy (mediaDomain "prowlarr"))
     #den.aspects.services._.media._.radarr
     #(den.aspects.services._.media._.radarr._.setupCaddy (mediaDomain "radarr"))
     #den.aspects.services._.media._.sonarr
     #(den.aspects.services._.media._.sonarr._.setupCaddy (mediaDomain "sonarr"))

      (den.aspects.services._.ddclient {
        protocol = "cloudflare";
        domains = [ "henriquekh.dev.br" ];
        zone = "henriquekh.dev.br";
        sopsFile = ./secrets/ddclient.yaml;
      })

      # (den.aspects.services._.forgejo-runner._.addInstance {
      #   name = "henrique-pc";
      #   url = "https://codeberg.org";
      #   sopsFile = ./secrets/forgejo-runner.env;
      # })
      # (den.aspects.utils._.disk._.addSubvolume {
      #   name = "ssd";
      #   subvolume = "forgejo-runner";
      #   mountpoint = "/var/lib/private/gitea-runner";
      # })

      (den.aspects.utils._.disk._.addSubvolume {
        name = "ssd";
        subvolume = "servers";
        mountpoint = "/media/servers";
      })
      (den.aspects.utils._.disk._.addSubvolume {
        name = "ssd";
        subvolume = "games";
        mountpoint = "/media/games";
      })
      (den.aspects.utils._.disk._.addSubvolume {
        name = "ssd";
        subvolume = "steam-ssd";
        mountpoint = "/media/steam-ssd";
      })
      (den.aspects.utils._.disk._.addSubvolume {
        name = "hdd";
        subvolume = "steam-hdd";
        mountpoint = "/media/steam-hdd";
      })
      (den.aspects.utils._.disk._.addSubvolume {
        name = "hdd";
        subvolume = "recordings";
        mountpoint = "/media/recordings";
        extraMountOptions = [ ];
      })
      (den.aspects.utils._.disk._.addSubvolume {
        name = "hdd";
        subvolume = "storage";
        mountpoint = "/media/storage";
      })
      (den.aspects.utils._.disk._.addSubvolume {
        name = "hdd";
        subvolume = "media";
        mountpoint = "/media/media";
      })
    ];

    disko.devices.disk = {
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

    nixos =
      {
        config,
        lib,
        modulesPath,
        ...
      }:

      {
        imports = [
          (modulesPath + "/installer/scan/not-detected.nix")
        ];

        boot = {
          initrd = {
            availableKernelModules = [
              "xhci_pci"
              "ahci"
              "usb_storage"
              "usbhid"
              "sd_mod"
            ];
            kernelModules = [ ];
          };
          kernelModules = [ "kvm-intel" ];
          extraModulePackages = [ ];
        };
        hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

        fileSystems = {
          "/persist".neededForBoot = true;
          "/var/log".neededForBoot = true;
        };

        sops.age.sshKeyPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];
      };
  };
}
