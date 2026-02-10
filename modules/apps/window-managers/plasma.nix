{
  den.aspects.apps.provides.window-managers.provides.plasma.nixos =
    { pkgs, ... }:
    {
      services.desktopManager.plasma6.enable = true;
      environment.plasma6.excludePackages = with pkgs.kdePackages; [
        konsole
      ];
    };
}
