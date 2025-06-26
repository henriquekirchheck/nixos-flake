{
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 16;
    consoleMode = "max";
    memtest86.enable = true;
    edk2-uefi-shell.enable = true;
    netbootxyz.enable = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;
}
