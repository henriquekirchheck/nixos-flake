{
  den.aspects.apps.provides.games.provides.archipelago = {
    description = "archipelago";

    homeManager =
      { pkgs, ... }:
      {
        home.packages = [
          pkgs.archipelago
          pkgs.poptracker
        ];
      };
  };
}
