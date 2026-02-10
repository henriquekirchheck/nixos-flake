{
  den.aspects.apps.provides.media.provides.images.provides.krita.homeManager =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.krita ];
    };
}
