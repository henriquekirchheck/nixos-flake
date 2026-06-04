{ den, ... }:
let
  kernelDef =
    {
      kernel,
      includes ? [ ],
    }:
    {
      includes = [ den.aspects.system._.kernel ] ++ includes;
      nixos =
        { pkgs, ... }:
        {
          boot.kernelPackages = kernel pkgs;
        };
    };
in
{
  den.aspects.system.provides.kernel = {
    description = "Linux Kernel";

    nixos.boot = {
      kernel.sysctl."kernel.sysrq" = 1;
      kernelParams = [ "psi=1" ];
    };

    provides = {
      stable = kernelDef { kernel = pkgs: pkgs.linuxPackages_latest; };
      xanmod = kernelDef { kernel = pkgs: pkgs.linuxPackages_xanmod_latest; };
      zen = kernelDef { kernel = pkgs: pkgs.linuxPackages_zen; };
    };
  };
}
