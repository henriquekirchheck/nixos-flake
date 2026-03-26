{
  den.aspects.apps.provides.communication.provides.stoat.homeManager =
    { pkgs, ... }:
    {
      home.packages = [
        # pkgs.stoat-desktop
      ];
    };
}
