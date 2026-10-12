{
  lib,
  __findFile,
  ...
}:
{
  den.aspects.disk.btrfs = {
    includes = [
      <disko/module>
      <preservation>
      <preservation/rollback/btrfs>
    ];

    settings.device = lib.mkOption {
      description = "Device used for this disk";
      type = lib.types.str;
    };

    nixos = { config, host, ... }: {
      disko.devices.disk.main = {
        type = "disk";
        device = host.settings.disk.btrfs.device;
        content.type = "gpt";
        content.partitions = {
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
              postCreateHook = ''
                (
                	MNTPOINT=$(mktemp -d)
                  mount "${config.disko.devices.disk.main.content.partitions.nixos.device}" "$MNTPOINT" -o subvol=/
                  trap 'umount "$MNTPOINT"; rm -rf "$MNTPOINT"' EXIT
                  btrfs subvolume snapshot -r "$MNTPOINT"/root "$MNTPOINT"/blank
                )
              '';
              subvolumes = {
                "/root" = {
                  mountpoint = "/";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
                "/nix" = {
                  mountpoint = "/nix";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
                "/persist" = {
                  mountpoint = "/persist";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
                "/cache" = {
                  mountpoint = "/cache";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
                "/swap" = {
                  mountpoint = "/swap";
                  swap.swapfile.size = "32G";
                };
              };
            };
          };
        };
      };
      fileSystems = {
        "/persist".neededForBoot = true;
        "/cache".neededForBoot = true;
        "/nix".neededForBoot = true;
      };
    };
  };
}
