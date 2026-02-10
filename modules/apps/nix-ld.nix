{
  den.aspects.apps.provides.nix-ld = {
    description = "Dynamic Linking";
    nixos =
      { pkgs, ... }:
      {
        programs.nix-ld = {
          enable = true;
          libraries = with pkgs; [
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

            libxcomposite
            libxtst
            libxrandr
            libxext
            libx11
            libxfixes
            libGL
            libva
            pipewire
            libxcb
            libxdamage
            libxshmfence
            libxxf86vm
            libelf

            glib
            gtk3
            gtk4

            vulkan-loader
            libgbm
            libdrm
            libxcrypt
            coreutils
            pciutils
            zenity

            libxinerama
            libxcursor
            libxrender
            libxscrnsaver
            libxi
            libsm
            libice
            nspr
            nss
            cups
            libcap
            libusb1
            dbus-glib
            ffmpeg
            libudev0-shim

            icu
            libnotify
            gsettings-desktop-schemas

            libxt
            libxmu
            libogg
            libvorbis

            sdl3
            sdl3-image
            sdl3-ttf
            sdl2-compat
            SDL2_gfx
            SDL2_mixer
            SDL2_net
            SDL2_sound
            SDL2_ttf

            glew110
            libidn

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
            libxft
            libvdpau
            openal
            libgcrypt
            libgpg-error

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
        };
      };
  };
}
