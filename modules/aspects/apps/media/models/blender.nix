{ den, __findFile, ... }:
{
  den.aspects.apps.media.models.blender = {
    includes = [
      <apps/media/ffmpeg>
      (den.lib.policy.when ({ host, ... }: host.hasAspect <hardware/graphics/nvidia>) (
        <den/unfree> [
          "blender"
          "libcusolver"
          "libcusparse"
        ]
      ))
    ];
    homeManager =
      {
        osConfig,
        lib,
        pkgs,
        ...
      }:
      {
        home.packages = [
          (lib.mkMerge [
            pkgs.blender
            #(lib.mkIf (!osConfig.hardware.nvidia.enabled) pkgs.blender)
            #(lib.mkIf (osConfig.hardware.nvidia.enabled) pkgs.pkgsCuda.blender)
          ])
        ];
      };

    persistHome = _: { directories = [ ".config/blender" ]; };
  };
}
