{
  inputs,
  __findFile,
  ...
}:
{
  flake-file.inputs.preservation.url = "github:nix-community/preservation";

  den.quirks = {
    persist = "System paths to keep across reboots";
    persistHome = "Home paths to cache on disk";
    cache = "System paths to keep across reboots";
    cacheHome = "Home paths to cache on disk";
  };

  den.aspects.preservation = {
    includes = [
      <preservation/collectSystem>
      <preservation/collectHome>
    ];
    nixos = {
      imports = [ inputs.preservation.nixosModules.default ];
      preservation.enable = true;
      systemd.services.systemd-machine-id-commit = {
        unitConfig.ConditionPathIsMountPoint = [
          ""
          "/persist/etc/machine-id"
        ];
        serviceConfig.ExecStart = [
          ""
          "systemd-machine-id-setup --commit --root /persist"
        ];
      };
    };
    persist = _: {
      files = [
        {
          file = "/etc/machine-id";
          inInitrd = true;
          how = "symlink";
          configureParent = true;
        }
      ];
      directories = [
        {
          directory = "/var/lib/nixos";
          inInitrd = true;
        }
      ];
    };
    cache = _: {
      directories = [
        "/var/log"
        "/var/lib/systemd/timers"
        "/var/lib/systemd/coredump"
        "/var/lib/systemd/rfkill"
      ];
    };
  };

  den.aspects.preservation.collectSystem = {
    nixos =
      {
        persist,
        cache,
        lib,
        ...
      }:
      {
        preservation = {
          preserveAt = {
            "/persist" = {
              directories = lib.unique (lib.concatMap (e: e.directories or [ ]) persist);
              files = lib.unique (lib.concatMap (e: e.files or [ ]) persist);
            };
            "/cache" = {
              directories = lib.unique (lib.concatMap (e: e.directories or [ ]) cache);
              files = lib.unique (lib.concatMap (e: e.files or [ ]) cache);
            };
          };
        };
      };
  };

  den.aspects.preservation.collectHome = { user, ... }: {
    nixos =
      {
        persistHome,
        cacheHome,
        lib,
        ...
      }:
      {
        preservation = {
          preserveAt = {
            "/persist" = {
              users.${user.userName} = {
                directories = lib.unique (lib.concatMap (e: e.directories or [ ]) persistHome);
                files = lib.unique (lib.concatMap (e: e.files or [ ]) persistHome);
              };
            };
            "/cache" = {
              users.${user.userName} = {
                directories = lib.unique (lib.concatMap (e: e.directories or [ ]) cacheHome);
                files = lib.unique (lib.concatMap (e: e.files or [ ]) cacheHome);
              };
            };
          };
        };
      };
  };

  den.aspects.preservation.rollback.btrfs = {
    nixos =
      { pkgs, ... }:
      {
        boot.initrd.systemd.services = {
          rollback-btrfs = {
            description = "Rollback root subvolume to a clean state";
            unitConfig.DefaultDependencies = "no";
            serviceConfig = {
              Type = "oneshot";
              StandardOutput = "journal+console";
              StandardError = "journal+console";
            };
            wantedBy = [ "initrd.target" ];
            before = [ "sysroot.mount" ];
            requires = [ "initrd-root-device.target" ];
            after = [
              "initrd-root-device.target"
              "local-fs-pre.target"
            ];
            path = [
              pkgs.btrfs-progs
              pkgs.coreutils
              pkgs.util-linux
            ];

            script = ''
              mkdir /btrfs_tmp
              mount /dev/disk/by-label/nixos /btrfs_tmp

              delete_subvolume_recursively() {
                IFS=$'\n'
                for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
                  delete_subvolume_recursively "/btrfs_tmp/$i"
                done
                btrfs subvolume delete "$1"
              }

              # Backup current cache state
              mkdir -p /btrfs_tmp/old_roots
              btrfs subvolume snapshot /btrfs_tmp/root \
                "/btrfs_tmp/old_roots/$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")"

              # Backup current cache state
              mkdir -p /btrfs_tmp/old_caches
              btrfs subvolume snapshot /btrfs_tmp/cache \
                "/btrfs_tmp/old_caches/$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")"

              # Delete old root snapshots
              for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
                delete_subvolume_recursively "$i"
              done
              # Delete old cache snapshots
              for i in $(find /btrfs_tmp/old_caches/ -maxdepth 1 -mtime +30); do
                delete_subvolume_recursively "$i"
              done

              # Rollback root to a clean state
              delete_subvolume_recursively /btrfs_tmp/root
              btrfs subvolume snapshot /btrfs_tmp/blank /btrfs_tmp/root

              umount /btrfs_tmp
            '';
          };
        };
      };
  };
}
