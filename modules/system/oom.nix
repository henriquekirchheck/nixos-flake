{
  den,
  ...
}:
{
  den.default.includes = [ den.aspects.system._.oom ];

  den.aspects.system.provides.oom = {
    description = "Out of Memory Killer";

    nixos =
      { lib, ... }:
      {
        systemd.oomd.enable = lib.mkDefault false;
        services.earlyoom.enable = lib.mkDefault false;
      };

    provides = {
      earlyoom.nixos.services.earlyoom.enable = true;
      systemd-oomd.nixos = {
        boot.kernelParams = [ "psi=1" ];
        systemd.oomd = {
          enable = true;
          enableRootSlice = true;
          enableUserSlices = true;
        };
      };
    };
  };
}
