{
  den.aspects.apps.provides.documents.provides.zathura.homeManager =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.zathura ];
    };
}
