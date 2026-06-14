{ den, ... }:
{
  den.aspects.apps.provides.media.provides.ffmpeg = {
    includes = [ (den._.unfree [ "ffmpeg-full" ]) ];
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.ffmpeg-full ];
      };
  };

}
