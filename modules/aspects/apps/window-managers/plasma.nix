{ __findFile, ... }:
{
  den.aspects.apps.window-managers.plasma = {
    includes = [ <apps/display/wayland> ];
    nixos = { pkgs, ... }: {
      services.desktopManager.plasma6.enable = true;
      environment.plasma6.excludePackages = with pkgs.kdePackages; [
        konsole
      ];
    };
  };
}
