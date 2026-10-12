{
  den.aspects.apps.games.r2modman = {
    homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.r2modman ];
    };

    cacheHome = _: {
      directories = [ ".config/r2modmanPlus-local" ];
    };
  };
}
