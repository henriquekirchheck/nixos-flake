{ den, ... }:
{
  den.default.includes = [ den.aspects.hardware.bootloader ];
  den.aspects.hardware.bootloader = {
    nixos.boot.loader.efi.canTouchEfiVariables = true;
  };

  den.aspects.hardware.bootloader.systemd-boot = {
    includes = [ den.aspects.hardware.bootloader ];
    nixos.boot.loader.systemd-boot = {
      enable = true;
      configurationLimit = 16;
      consoleMode = "max";
      memtest86.enable = true;
      edk2-uefi-shell.enable = true;
      netbootxyz.enable = true;
    };
  };
}
