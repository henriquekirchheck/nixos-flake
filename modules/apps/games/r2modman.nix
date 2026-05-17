{
  den.aspects.apps.provides.games.provides.r2modman = {
    description = "r2modman";

    homeManager =
      { pkgs, ... }:
      {
        home.packages = [
          pkgs.r2modman
        ];
      };
  };
}
