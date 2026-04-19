{ inputs, den, ... }:
{
  flake-file.inputs.impermanence = {
    url = "github:nix-community/impermanence";
    inputs.nixpkgs.follows = "";
    inputs.home-manager.follows = "";
  };

  den.aspects.system.provides.impermanence = {
    description = "Root filesystem impermanence setup";

    nixos.imports = [ inputs.impermanence.nixosModules.impermanence ];

    provides = {
      addPersistance = mountpoint: {
        includes = [ den.aspects.system._.impermanence ];
        nixos.environment.persistence.${mountpoint}.hideMounts = true;
        fileSystems.${mountpoint}.neededForBoot = true;
      };
      addOptions = mountpoint: opts: {
        nixos.environment.persistence.${mountpoint} = opts;
      };
      setupBtrfs =
        {
          partlabel,
          rootSubvolume ? "root",
        }:
        {
          nixos =
            { lib, pkgs, ... }:
            {
              boot.initrd.systemd = {
                services.impermanence-btrfs = {
                  description = "Archiving current BTRFS root";
                  unitConfig.DefaultDependencies = false;
                  serviceConfig.Type = "oneshot";
                  requiredBy = [ "initrd.target" ];
                  before = [ "sysroot.mount" ];
                  requires = [ "initrd-root-device.target" ];
                  after = [
                    "initrd-root-device.target"
                    "local-fs-pre.target"
                  ];

                  script = ''
                    mkdir /btrfs_tmp
                    mount /dev/disk/by-partlabel/${partlabel} /btrfs_tmp
                    if [[ -e /btrfs_tmp/${rootSubvolume} ]]; then
                        mkdir -p /btrfs_tmp/old_roots
                        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/${rootSubvolume})" "+%Y-%m-%-d_%H:%M:%S")
                        mv /btrfs_tmp/${rootSubvolume} "/btrfs_tmp/old_roots/$timestamp"
                    fi

                    delete_subvolume_recursively() {
                        IFS=$'\n'
                        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
                            delete_subvolume_recursively "/btrfs_tmp/$i"
                        done
                        btrfs subvolume delete "$1"
                    }

                    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
                        delete_subvolume_recursively "$i"
                    done

                    btrfs subvolume create /btrfs_tmp/${rootSubvolume}
                    umount /btrfs_tmp
                  '';
                };
                extraBin = {
                  "mkdir" = lib.getExe' pkgs.coreutils "mkdir";
                  "date" = lib.getExe' pkgs.coreutils "date";
                  "stat" = lib.getExe' pkgs.coreutils "stat";
                  "mv" = lib.getExe' pkgs.coreutils "mv";
                  "find" = lib.getExe' pkgs.coreutils "find";
                  "btrfs" = lib.getExe pkgs.btrfs-progs;
                };
              };
            };
        };
    };
  };
}
