{ den, ... }:
{
  den.aspects.apps.provides.media.provides.models.provides.blender = {
    includes = [
      (den._.unfree [
        "blender"
        "cuda_cudart"
        "cuda_cccl"
        "cuda_nvcc"
        "cuda_nvrtc"
        "libcublas"
      ])
    ];
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.pkgsCuda.blender ];
      };
  };
}
