{ den, ... }:
{
  den.aspects.apps.provides.media.provides.audio.provides.tidal-hifi = {
    includes = [ (den._.unfree [ "tidal-hifi" ]) ];
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.tidal-hifi ];
      };
  };
}
