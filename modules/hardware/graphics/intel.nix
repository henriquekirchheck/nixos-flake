{ den, ... }:
{
  den.aspects.hardware.provides.graphics.provides.intel = {
    includes = [ den.aspects.hardware._.graphics ];
    nixos =
      { pkgs, ... }:
      {
        services.xserver.videoDrivers = [ "modesetting" ];

        hardware.graphics = {
          extraPackages = with pkgs; [
            intel-media-driver
            vpl-gpu-rt
            intel-compute-runtime
          ];
        };

        environment.sessionVariables = {
          LIBVA_DRIVER_NAME = "iHD";
        };
      };
  };
}
