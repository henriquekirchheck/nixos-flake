{
  den.aspects.apps.provides.games.provides.gamescope.nixos =
    { pkgs, ... }:
    {
      programs.gamescope = {
        enable = true;
        capSysNice = true;
      };
      environment.systemPackages = [ pkgs.gamescope-wsi ];
    };
}
