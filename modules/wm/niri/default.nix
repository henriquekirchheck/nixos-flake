{ inputs, pkgs, ... }:

{
  imports = [ inputs.niri.nixosModules.niri ];
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };
  niri-flake.cache.enable = false;
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
    config.niri = {
      default = [
        "gnome"
        "gtk"
      ];
      "org.freedesktop.impl.portal.ScreenCast" = "gnome";
      "org.freedesktop.impl.portal.FileChooser" = "gtk";
      "org.freedesktop.impl.portal.Access" = "gtk";
      "org.freedesktop.impl.portal.Notification" = "gtk";
      "org.freedesktop.impl.portal.AppChooser" = "gtk";
      "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
    };
  };

  # Fix services starting before niri-session
  systemd.user.services = {
    xdg-desktop-portal = {
      after = [ "xdg-desktop-autostart.target" ];
    };
    xdg-desktop-portal-gtk = {
      after = [ "xdg-desktop-autostart.target" ];
    };
    xdg-desktop-portal-gnome = {
      after = [ "xdg-desktop-autostart.target" ];
    };
    niri-flake-polkit = {
      after = [ "xdg-desktop-autostart.target" ];
    };
  };
}
