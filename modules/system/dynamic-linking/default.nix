{
  pkgs,
  lib,
  inputs,
  ...
}:

let
  buildPkgList =
    pkgs: with pkgs; [
      # List by default
      zlib
      zstd
      stdenv.cc.cc
      curl
      openssl
      attr
      libssh
      bzip2
      libxml2
      acl
      libsodium
      util-linux
      xz
      systemd

      # My own additions
      xorg.libXcomposite
      xorg.libXtst
      xorg.libXrandr
      xorg.libXext
      xorg.libX11
      xorg.libXfixes
      libGL
      libva
      pipewire
      xorg.libxcb
      xorg.libXdamage
      xorg.libxshmfence
      xorg.libXxf86vm
      libelf

      # Required
      glib
      gtk3
      gtk4

      # Inspired by steam
      vulkan-loader
      libgbm
      libdrm
      libxcrypt
      coreutils
      pciutils
      zenity

      # # Without these it silently fails
      xorg.libXinerama
      xorg.libXcursor
      xorg.libXrender
      xorg.libXScrnSaver
      xorg.libXi
      xorg.libSM
      xorg.libICE
      nspr
      nss
      cups
      libcap
      libusb1
      dbus-glib
      ffmpeg
      libudev0-shim

      # needed to run unity
      icu
      libnotify
      gsettings-desktop-schemas

      # Verified games requirements
      xorg.libXt
      xorg.libXmu
      libogg
      libvorbis

      # sdl3
      # sdl3-image
      # sdl3-ttf
      # sdl2-compat
      # SDL2_gfx
      # SDL2_mixer
      # SDL2_net
      # SDL2_sound
      # SDL2_ttf

      glew110
      libidn

      # Other things from runtime
      flac
      freeglut
      libjpeg
      libpng
      libpng12
      libsamplerate
      libmikmod
      libtheora
      libtiff
      pixman
      speex
      libcaca
      libcanberra
      libgcrypt
      libvpx
      librsvg
      xorg.libXft
      libvdpau
      openal
      libgcrypt
      libgpg-error

      # Some more libraries that I needed to run programs
      pango
      cairo
      atk
      gdk-pixbuf
      fontconfig
      freetype
      dbus
      alsa-lib
      expat
      libxkbcommon

      libxcrypt-legacy # For natron
      libGLU # For natron

      libnotify
    ];

  buildSystemSet =
    pkgsList:
    builtins.listToAttrs (
      map (
        { ldso, pkgs }:
        {
          name = pkgs.stdenv.buildPlatform.system;
          value = {
            package = inputs.nix-ld.packages.${pkgs.stdenv.hostPlatform.system}.default;
            inherit pkgs;
            libraries = buildPkgList pkgs;
            inherit ldso;
          };
        }
      ) pkgsList
    );
in
{
  imports = [ ./module.nix ];
  # programs.nix-ld = {
  #   enable = true;
  #   libraries = buildPkgList pkgs;
  # };

  programs.nix-ld-local.systems = buildSystemSet [
    {
      ldso = "ldso";
      inherit pkgs;
    }
    {
      ldso = "ldso32";
      pkgs = pkgs.pkgsi686Linux;
    }
  ];
}
