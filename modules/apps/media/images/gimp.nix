{
  den.aspects.apps.provides.media.provides.images.provides.gimp.homeManager =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.gimp-with-plugins ];
    };
}
