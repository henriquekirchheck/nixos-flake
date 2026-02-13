{ den, ... }:
{
  den.aspects.laptop = {
    includes = [
      (den.aspects.utils._.host._.locale {
        default = "pt_BR.UTF-8";
        extra = "pt_BR.UTF-8";
      })

      den.aspects.apps._.sops
      den.aspects.apps._.nix
      den.aspects.apps._.nix-ld

      den.aspects.hardware._.networking._.network-manager
      den.aspects.hardware._.audio._.pipewire
      den.aspects.hardware._.graphics._.amdgpu
      den.aspects.hardware._.graphics._.intel

      den.aspects.system._.bootloader._.systemd-boot
      den.aspects.system._.kernel._.xanmod
      den.aspects.system._.oom._.systemd-oomd

      den.aspects.services._.ssh._.server

      den.aspects.apps._.display-managers._.cosmic-greeter

      den.aspects.apps._.containers._.podman
      den.aspects.apps._.virtualisation._.qemu
      den.aspects.apps._.virtualisation._.virt-manager
    ];

    disko.disko.devices.disk = {
      system = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              name = "ESP";
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              name = "root";
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [
                  "-L"
                  "root"
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
                  "/docker" = {
                    mountpoint = "/var/lib/docker";
                    mountOptions = [
                      "subvol=docker"
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
            popups = 0.75;
            desktop = 0.75;
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
              package = pkgs.roboto;
              name = "Roboto";
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
          "sd_mod"
          "rtsx_usb_sdmmc"
        ];
        boot.initrd.kernelModules = [ ];
        boot.kernelModules = [ "kvm-intel" ];
        boot.extraModulePackages = [ ];
        hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      };
  };
}
