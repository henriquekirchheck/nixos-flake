{ den, ... }:
{
  den.aspects.hardware.provides.graphics = {
    provides = {
      nvidia = {
        includes = [
          den.aspects.hardware._.graphics
          (den._.unfree [
            "nvidia-x11"
            "nvidia-settings"
            "nvidia-kernel-modules"
          ])
          (den.aspects.utils._.nixpkgs._.add-substituter {
            substituter = "https://cache.nixos-cuda.org";
            public-key = "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=";
          })
        ];
        nixos =
          { config, ... }:
          {
            services.xserver.videoDrivers = [ "nvidia" ];
            hardware.nvidia = {
              package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
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
