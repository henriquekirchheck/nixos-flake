{
  den.aspects.apps.fetch.onefetch = {
    homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.onefetch ];
    };
  };
}
