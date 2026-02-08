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
            { lib, ... }:
            {
              boot.initrd.postResumeCommands = lib.mkAfter ''
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
        };
    };
  };
}
