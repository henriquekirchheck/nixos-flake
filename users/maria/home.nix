{ ... }:
{
  imports = [
    ../../modules/programs/browsers/chromium/home.nix
    ../../modules/programs/mpv
    ../../modules/programs/gimp
    ../../modules/programs/ffmpeg
    ../../modules/programs/libreoffice

    ../../modules/hardware/bluetooth/home.nix

    ../../modules/compatibility/wine
    ../../modules/compatibility/bottles
    ../../modules/system/virtualisation/containers/distrobox.nix

    ../../modules/programs/terminal/kitty
  ];

  # Home Specific
  home.username = "maria";
  home.homeDirectory = "/home/maria";
  home.stateVersion = "25.05";

  ## Integration
  home.shell.enableShellIntegration = true;

  ## Prefer wayland
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland,x11,*";
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    GTK_USE_PORTAL = "1";
  };

  ## Defaults
  home.sessionVariables = {
    BROWSER = "chromium";
  };

  # XDG Dirs
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
    mime.enable = true;
    mimeApps.enable = true;
  };
}
