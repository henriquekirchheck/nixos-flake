{
  den.aspects.apps.provides.wayland.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        wl-clipboard
        dragon-drop
        xwayland-run
        openbox
      ];
      environment.variables = {
        NIXOS_OZONE_WL = "1";
        GDK_BACKEND = "wayland";
        QT_QPA_PLATFORM = "wayland;xcb";
        SDL_VIDEODRIVER = "wayland";
        CLUTTER_BACKEND = "wayland";
        MOZ_ENABLE_WAYLAND = "1";
        GTK_USE_PORTAL = "1";
      };
    };
}
