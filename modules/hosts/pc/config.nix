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
      den.aspects.apps._.nix-ld
      den.aspects.apps._.media._.audio._.mpd

      (den.aspects.hardware._.networking._.systemd._.networkd._.static-config {
        address = "10.0.0.10/24";
        gateway = "10.0.0.1";
      })
      den.aspects.hardware._.audio._.pipewire
      den.aspects.hardware._.graphics._.nvidia

      den.aspects.services._.zerotier
      den.aspects.services._.ssh._.server

      den.aspects.system._.bootloader._.systemd-boot
      den.aspects.system._.kernel._.cachy._.stable-v3
      den.aspects.system._.oom._.systemd-oomd

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

      den.aspects.services._.vaultwarden
      (den.aspects.services._.vaultwarden._.includeEnvironment ./secrets/vaultwarden.env)
      (den.aspects.services._.vaultwarden._.setupCloudflareTunnel "52ba507f-2e7c-4527-9010-aaa4ff579fa2" "vault.henriquekh.dev.br")

      (den.aspects.services._.bitwarden-sync ./secrets/bitwarden-sync.env)

      den.aspects.services._.searxng
      (den.aspects.services._.searxng._.includeEnvironment ./secrets/searxng.env)
      (den.aspects.services._.searxng._.setupCloudflareTunnel "52ba507f-2e7c-4527-9010-aaa4ff579fa2" "search.henriquekh.dev.br")

      den.aspects.services._.media
      (den.aspects.services._.media._.setupCaddy (
        let
          domain = service: [
            "${service}.localhost"
            "${service}.zt.henriquekh.dev.br"
            "${service}.henriquekh.dev.br"
          ];
        in
        {
          jelly = domain "jelly";
          qbit = domain "qbit";
          radarr = domain "radarr";
          sonarr = domain "sonarr";
          bazarr = domain "bazarr";
          prowlarr = domain "prowlarr";
        }
      ))
      (den.aspects.services._.media._.setupCloudflareTunnel "52ba507f-2e7c-4527-9010-aaa4ff579fa2" "jelly.henriquekh.dev.br")

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

    stylix =
      { pkgs, ... }:
      {
        stylix = {
          enable = true;
          base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
          polarity = "dark";
          cursor = {
            package = pkgs.phinger-cursors;
            name = "phinger-cursors-light";
            size = 24;
          };
          opacity = {
            terminal = 0.75;
            applications = 0.98;
          };
          icons = {
            enable = true;
            package = pkgs.papirus-icon-theme;
            dark = "Papirus-Dark";
            light = "Papirus-Light";
          };
          fonts = {
            serif = {
              package = pkgs.roboto;
              name = "Roboto";
            };
            sansSerif = {
              package = pkgs.roboto-serif;
              name = "Roboto Serif";
            };
            monospace = {
              package = pkgs.nerd-fonts.jetbrains-mono;
              name = "JetBrainsMono Nerd Font";
            };
            emoji = {
              package = pkgs.noto-fonts-color-emoji;
              name = "Noto Color Emoji";
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

        boot.initrd.availableKernelModules = [
          "xhci_pci"
          "ahci"
          "usb_storage"
          "usbhid"
          "sd_mod"
        ];
        boot.initrd.kernelModules = [ ];
        boot.kernelModules = [ "kvm-intel" ];
        boot.extraModulePackages = [ ];
        hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

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
