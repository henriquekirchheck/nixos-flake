{ den, ... }:
{
  den.aspects.hardware.provides.graphics = {
    provides = {
      nvidia = {
        includes = [ den.aspects.hardware._.graphics ];
        nixos =
          { config, ... }:
          {
            services.xserver.videoDrivers = [ "nvidia" ];
            hardware.nvidia = {
              package = config.boot.kernelPackages.nvidiaPackages.stable;
              nvidiaSettings = true;
              nvidiaPersistenced = true;
              open = false;
              modesetting.enable = true;
              videoAcceleration = true;
            };
            hardware.nvidia-container-toolkit.enable = true;
          };
      };
      nouveau = {
        includes = [ den.aspects.hardware._.graphics ];
        nixos =
          { lib, ... }:
          {
            services.xserver.videoDrivers = lib.mkForce [ ];
            hardware.nvidia = {
              nvidiaSettings = lib.mkForce false;
              nvidiaPersistenced = lib.mkForce false;
              modesetting.enable = lib.mkForce false;
              videoAcceleration = lib.mkForce false;
            };
            hardware.nvidia-container-toolkit.enable = lib.mkForce false;
          };
      };
    };
  };
}
