let
  partitionName = "volume";
in
{
  den.aspects.utils.provides.disk = {
    description = "Creates and mantains a btrfs disk that can have new subvolumes added as needed";
    provides = {
      createDisk =
        { name, device }:
        {
          description = "Create a new disk with the specified name on the specified device";
          disko.disko.devices.disk.${name} = {
            type = "disk";
            inherit device;
            content = {
              type = "gpt";
              partitions.${partitionName} = {
                size = "100%";
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-L"
                    name
                    "-f"
                  ];
                };
              };
            };
          };
        };
      addSubvolume =
        {
          name,
          subvolume,
          mountpoint,
        }:
        {
          description = "Create a subvolume on the disk with the specified name";
          disko.disko.devices.disk.${name}.content.partitions.${partitionName}.content.subvolumes."/${subvolume}" =
            {
              inherit mountpoint;
              mountOptions = [
                "subvol=${subvolume}"
                "compress=zstd"
                "noatime"
              ];
            };
        };
    };
  };
}
