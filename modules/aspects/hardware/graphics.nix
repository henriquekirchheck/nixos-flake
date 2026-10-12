{
  lib,
  __findFile,
  ...
}:
{
  den.default.includes = [ <hardware/graphics> ];
  den.aspects.hardware.graphics = {
    nixos.hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  den.aspects.hardware.graphics.nvidia = {
    includes = [
      <hardware/graphics>
      (<den/unfree> [
        "nvidia-x11"
        "nvidia-settings"
        "nvidia-kernel-modules"
      ])
    ];
    settings.legacy = lib.mkOption {
      description = "Use legacy driver for non-RTX cards";
      type = lib.types.bool;
      default = false;
    };
    nixos = { host, config, ... }: {
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        package = lib.mkMerge [
          (lib.mkIf (host.settings.hardware.graphics.nvidia.legacy) config.boot.kernelPackages.nvidiaPackages.legacy_580)
          (lib.mkIf (
            !host.settings.hardware.graphics.nvidia.legacy
          ) config.boot.kernelPackages.nvidiaPackages.latest)
        ];
        nvidiaSettings = true;
        nvidiaPersistenced = true;
        open = !host.settings.hardware.graphics.nvidia.legacy;
        modesetting.enable = true;
        videoAcceleration = true;
      };
    };
    nixpkgs-substituters = _: [
      {
        substituter = "https://cache.nixos-cuda.org";
        public-key = "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=";
      }
    ];
  };

  den.aspects.hardware.graphics.intel = {
    includes = [ <hardware/graphics> ];
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

  den.aspects.hardware.graphics.amd = {
    includes = [ <hardware/graphics> ];
    nixos.hardware.amdgpu.opencl.enable = true;
  };
}
