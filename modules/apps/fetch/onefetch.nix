{
  den.aspects.apps.provides.fetch.provides.onefetch = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.onefetch ];
      };
  };
}
