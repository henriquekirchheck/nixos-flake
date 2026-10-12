{ den, __findFile, ... }:
{
  den.aspects.apps.media.ffmpeg = {
    includes = [
      (den.lib.policy.when ({ host, ... }: host.hasAspect <hardware/graphics/nvidia>) (
        <den/unfree> [
          "ffmpeg"
          "ffmpeg-full"
          "cuda_cudart"
          "cuda_nvcc"
          "cuda_cccl"
          "cuda_nvrtc"
          "libnpp"
          "libcublas"
          "libcufft"
          "libnvjitlink"
        ]
      ))
    ];
    nixos =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        environment.systemPackages = [
          (lib.mkMerge [
            pkgs.ffmpeg-full
            #(lib.mkIf (!config.hardware.nvidia.enabled) pkgs.ffmpeg-full)
            #(lib.mkIf (config.hardware.nvidia.enabled) pkgs.pkgsCuda.ffmpeg-full)
          ])
        ];
      };
  };
}
