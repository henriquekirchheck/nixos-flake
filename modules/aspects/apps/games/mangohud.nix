{
  den.aspects.apps.games.mangohud = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = [ pkgs.mangohud ];
    };
  };
}
