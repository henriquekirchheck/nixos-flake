{ den, ... }:
let
  kernelDef = kernel: {
    nixos =
      { pkgs, ... }:
      {
        boot.kernelPackages = kernel pkgs;
      };
  };
in
{
  den.default.includes = [ den.aspects.hardware.kernel ];

  den.aspects.hardware.kernel = {
    nixos.boot.kernel.sysctl."kernel.sysrq" = 1;

    stable = kernelDef (pkgs: pkgs.linuxPackages_latest);
    xanmod = kernelDef (pkgs: pkgs.linuxPackages_xanmod_latest);
    zen = kernelDef (pkgs: pkgs.linuxPackages_zen);
  };
}
