{
  den.aspects.apps.provides.media.provides.ffmpeg = {
    nixos =
      { pkgs, config, ... }:
      {

        environment.systemPackages =
          let
            ffmpeg =
              # TODO: Unfree battery broken https://github.com/vic/den/issues/150
              # if config.hardware.nvidia.enabled then
              #   (pkgs.ffmpeg-full.override { withUnfree = true; }).overrideAttrs (_: {
              #     doCheck = false;
              #   })
              # else
              pkgs.ffmpeg-full;
          in
          [ ffmpeg ];
      };
  };

}
