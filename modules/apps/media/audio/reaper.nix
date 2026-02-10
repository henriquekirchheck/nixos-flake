{
  den.aspects.apps.provides.media.provides.audio.provides.reaper.homeManager =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.reaper ];
    };
}
