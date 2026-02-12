{ den, ... }:
{
  den.aspects.apps.provides.media.provides.audio.provides.tidal-hifi = {
    includes = [
      (den._.unfree [
        "tidal-hifi"
        "castlabs-electron"
      ])
    ];
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.tidal-hifi ];
      };
  };
}
