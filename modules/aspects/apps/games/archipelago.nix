{
  den.aspects.apps.games.archipelago = {
    homeManager = { pkgs, ... }: {
      home.packages = [
        pkgs.archipelago
        pkgs.poptracker
      ];
    };
  };
}
