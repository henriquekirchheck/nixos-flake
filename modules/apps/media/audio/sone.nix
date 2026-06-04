{
  den.aspects.apps.provides.media.provides.audio.provides.sone.homeManager =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.sone ];
    };
}
