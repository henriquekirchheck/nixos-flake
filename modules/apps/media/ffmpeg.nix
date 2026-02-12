{ den, ... }:
{
  den.aspects.apps.provides.media.provides.ffmpeg = {
    includes = [ (den._.unfree [ "ffmpeg-full" ]) ];
    nixos =
      { pkgs, config, ... }:
      {
        environment.systemPackages =
          let
            ffmpeg =
              if config.hardware.nvidia.enabled then
                (pkgs.ffmpeg-full.override { withUnfree = true; }).overrideAttrs (_: {
                  doCheck = false;
                })
              else
                pkgs.ffmpeg-full;
          in
          [ ffmpeg ];
      };
  };

}
