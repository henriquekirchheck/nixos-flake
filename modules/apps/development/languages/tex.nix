{
  den.aspects.apps.provides.development.provides.languages.provides.tex.homeManager =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.tectonic ];
    };
}
