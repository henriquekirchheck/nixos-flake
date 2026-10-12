{
  den.aspects.apps.display.wayland.defaults = {
    nixos.environment.variables = {
      NIXOS_OZONE_WL = "1";
      GDK_BACKEND = "wayland";
      QT_QPA_PLATFORM = "wayland;xcb";
      SDL_VIDEODRIVER = "wayland,x11";
      CLUTTER_BACKEND = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      GTK_USE_PORTAL = "1";
    };
  };
}
