{
  den.aspects.apps.provides.media.provides.audio.provides.ardour.homeManager =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.ardour ];
    };
}
