{
  __findFile,
  lib,
  ...
}:
{
  den.aspects.disk.drive = {
    includes = [ <disko/module> ];
    settings = {
      cacheDevice = lib.mkOption {
        description = "Device used for fast access";
        type = lib.types.str;
      };
      cacheSize = lib.mkOption {
        description = "Porcentage size of the cache logical volume in the cache device";
        type = lib.types.str;
        default = "100%";
      };
      storageDevices = lib.mkOption {
        description = "Devices used for storage";
        type = lib.types.listOf lib.types.str;
      };
      subvolumes = lib.mkOption {
        description = "BTRFS Subvolumes to be created in drive";
        type = lib.types.attrsOf (
          lib.types.submodule {
            options = {
              mountpoint = lib.mkOption {
                type = lib.types.str;
                description = "Mountpoint of the subvolume";
              };
              mountOptions = lib.mkOption {
                type = lib.types.listOf lib.types.str;
                default = [
                  "noatime"
                  "compress=zstd"
                ];
                description = "mountoptions of the subvolume";
              };
            };
          }
        );
      };
    };

    nixos = { config, host, ... }: {
      boot = rec {
        kernelModules = [
          "dm-cache-default"
        ];
        initrd = { inherit kernelModules; };
      };
      services.lvm.boot.thin.enable = true;

      disko.devices = {
        disk =
          let
            createLVMPV = device: {
              inherit device;
              type = "disk";
              content.type = "gpt";
              content.partitions.cache = {
                size = "100%";
                content = {
                  type = "lvm_pv";
                  vg = "drive_pool";
                };
              };
            };
          in
          lib.mkMerge [
            (lib.genAttrs (lib.singleton host.settings.disk.drive.cacheDevice) createLVMPV)
            (lib.genAttrs host.settings.disk.drive.storageDevices createLVMPV)
          ];
        lvm_vg = {
          drive_pool = {
            type = "lvm_vg";
            lvs = {
              cache_meta = {
                priority = 0;
                size = "4G";
                extraArgs = [
                  "drive_pool"
                  (config.disko.devices.disk.${host.settings.disk.drive.cacheDevice}.content.partitions.cache.device)
                  ";"
                  "echo"
                ];
              };
              cache_data = {
                priority = 1;
                size = "${host.settings.disk.drive.cacheSize}FREE";
                extraArgs = [
                  "drive_pool"
                  (config.disko.devices.disk.${host.settings.disk.drive.cacheDevice}.content.partitions.cache.device)
                  ";"
                  "echo"
                ];
              };
              drive = {
                priority = 10;
                size = "99%FREE";
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-L"
                    "drive"
                    "-f"
                  ];
                  inherit (host.settings.disk.drive) subvolumes;
                };
              };
            };
            postCreateHook = ''
              lvconvert --yes --type cache-pool --cachemode writeback --poolmetadata drive_pool/cache_meta drive_pool/cache_data
              lvconvert --yes --type cache --cachepool drive_pool/cache_data drive_pool/drive
            '';
          };
        };
      };
    };
  };
}
