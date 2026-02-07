{ den, ... }:
{
  den.aspects.system.provides.bootloader = {
    description = "Bootloaders";
    nixos.boot.loader.efi.canTouchEfiVariables = true;
    provides = {
      systemd-boot = {
        includes = [ den.aspects.system._.bootloader ];
        nixos.boot.loader.systemd-boot = {
          enable = true;
          configurationLimit = 16;
          consoleMode = "max";
          memtest86.enable = true;
          edk2-uefi-shell.enable = true;
          netbootxyz.enable = true;
        };
      };
    };
  };
}
