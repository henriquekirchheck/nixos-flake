{
  den.aspects.apps.provides.keyrings.provides.gnome-keyring = {
    nixos.services.gnome.gnome-keyring.enable = true;
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [
          pkgs.seahorse
          pkgs.gcr
        ];
        xdg.portal = {
          extraPortals = [ pkgs.gnome-keyring ];
          config.common."org.freedesktop.impl.portal.Secret" = "gnome-keyring";
        };
      };
  };
}
