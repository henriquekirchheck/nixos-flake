{
  den.aspects.apps.provides.games.provides.mangohud.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.mangohud ];
    };
}
