{
  den.aspects.apps.provides.media.provides.images.provides.oculante.homeManager =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.oculante ];
    };
}
