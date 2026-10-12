{ __findFile, ... }:
{
  den.aspects.apps.games.steam = {
    includes = [
      (<den/unfree> [
        "steam"
        "steam-unwrapped"
      ])
    ];

    nixos = { pkgs, ... }: {
      programs.steam = {
        enable = true;
        protontricks.enable = true;
        package = pkgs.steam.override {
          extraEnv = {
            VKD3D_CONFIG = "dxr,dxr12";
            PROTON_NO_WM_DECORATION = "1";
            PROTON_LOCAL_SHADER_CACHE = "1";
          };
          extraPkgs =
            pkgs': with pkgs'; [
              libxcursor
              libxi
              libxinerama
              libxscrnsaver
              libpng
              libpulseaudio
              libvorbis
              stdenv.cc.cc.lib
              libkrb5
              keyutils
              gamemode
              xwayland-run
              openbox
              feh
            ];
        };
        extraCompatPackages = with pkgs; [
          proton-ge-bin
          dwproton-bin
          steam-play-none
        ];

        dedicatedServer.openFirewall = true;
        remotePlay.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        extest.enable = true;
      };
    };

    niri-window-rules = _: [
      {
        matches = [
          {
            app-id = "steam";
            title = ''^notificationtoasts_\d+_desktop$'';
          }
        ];
        default-floating-position = {
          x = 10;
          y = 10;
          relative-to = "bottom-right";
        };
        open-focused = false;
        opacity = 0.95;
        background-effect = {
          blur = true;
          xray = false;
        };
      }
    ];

    persistHome = _: {
      directories = [ ".local/share/Steam" ];
    };
  };
}
