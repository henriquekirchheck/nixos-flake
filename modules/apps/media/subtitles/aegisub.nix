{
  den.aspects.apps.provides.media.provides.subtitles.provides.aegisub.homeManager =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.aegisub ];
    };
}
