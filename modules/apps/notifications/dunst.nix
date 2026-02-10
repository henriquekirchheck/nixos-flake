{
  den.aspects.apps.provides.notifications.provides.dunst.homeManager =
    { pkgs, ... }:
    {
      services.dunst = {
        enable = true;
        iconTheme = {
          package = pkgs.papirus-icon-theme;
          name = "Papirus-Dark";
          size = "32x32";
        };
      };
    };
}
