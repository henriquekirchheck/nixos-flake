{
  inputs,
  den,
  ...
}:
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
  flake-file.inputs.nix-cachyos-kernel = {
    url = "github:xddxdd/nix-cachyos-kernel/release";
    inputs.flake-parts.follows = "flake-parts";
  };

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
      cachy = {
        includes = [
          (den.aspects.utils._.nixpkgs._.add-substituter {
            substituter = "https://attic.xuyh0120.win/lantian";
            public-key = "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=";
          })
          (den.aspects.utils._.nixpkgs._.add-overlay inputs.nix-cachyos-kernel.overlays.pinned)
        ];
        provides = {
          stable = kernelDef {
            includes = [ den.aspects.system._.kernel._.cachy ];
            kernel = pkgs: pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto;
          };
          stable-v3 = kernelDef {
            includes = [ den.aspects.system._.kernel._.cachy ];
            kernel = pkgs: pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;
          };
          bore = kernelDef {
            includes = [ den.aspects.system._.kernel._.cachy ];
            kernel = pkgs: pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto;
          };
          realtime = kernelDef {
            includes = [ den.aspects.system._.kernel._.cachy ];
            kernel = pkgs: pkgs.cachyosKernels.linuxPackages-cachyos-rt-bore-lto;
          };
        };
      };
    };
  };
}
