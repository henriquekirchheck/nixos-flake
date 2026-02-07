{
  den.aspects.hardware.provides.tablet = {
    nixos = {
      hardware.opentabletdriver.enable = true;
      hardware.uinput.enable = true;
      boot.kernelModules = [ "uinput" ];
    };
  };
}
