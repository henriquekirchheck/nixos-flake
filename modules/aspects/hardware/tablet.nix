{
  den.aspects.hardware.tablet = {
    nixos = {
      hardware = {
        opentabletdriver.enable = true;
        uinput.enable = true;
      };
      boot.kernelModules = [ "uinput" ];
    };
    cacheHome = _: {
      directories = [ ".config/OpenTabletDriver" ];
    };
  };
}
