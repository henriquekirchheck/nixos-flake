{
  den.aspects.apps.provides.communication.provides.fractal.homeManager =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.fractal
      ];
    };
}
