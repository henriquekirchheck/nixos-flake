{ den, ... }:
{
  den.aspects.apps.provides.window-managers.provides.plasma = {
    includes = [ den.aspects.apps._.wayland ];
    nixos =
      { pkgs, ... }:
      {
        services.desktopManager.plasma6.enable = true;
        environment.plasma6.excludePackages = with pkgs.kdePackages; [
          konsole
        ];
      };
  };
}
