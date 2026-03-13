{ den, inputs, ... }:
{
  flake-file.inputs = {
    nix-gaming-edge = {
      url = "github:powerofthe69/nix-gaming-edge";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        millennium.follows = "";
      };
    };
  };

  den.default.includes = [
    (den.aspects.utils._.nixpkgs._.add-substituter {
      substituter = "https://nix-cache.tokidoki.dev/tokidoki";
      public-key = "tokidoki:MD4VWt3kK8Fmz3jkiGoNRJIW31/QAm7l1Dcgz2Xa4hk=";
    })
    (den.aspects.utils._.nixpkgs._.add-overlay inputs.nix-gaming-edge.overlays.default)
  ];

  den.aspects.apps.provides.games.provides.steam = {
    includes = [
      (den._.unfree [
        "steam"
        "steam-unwrapped"
      ])
    ];

    nixos =
      { pkgs, ... }:
      {
        programs.steam = {
          enable = true;
          package = pkgs.steam.override {
            extraEnv = {
              MANGOHUD = "1";
              MANGOHUD_CONFIG = "read_cfg,no_display";
              VKD3D_CONFIG = "dxr,dxr12";
              PROTON_ENABLE_WAYLAND = "1";
              PROTON_NO_WM_DECORATION = "1";
              PROTON_LOCAL_SHADER_CACHE = "1";
            };
          };
          extraCompatPackages = with pkgs; [
            proton-ge-bin
            proton-cachyos-x86_64-v3
          ];
          protontricks.enable = true;

          dedicatedServer.openFirewall = true;
          remotePlay.openFirewall = true;
          localNetworkGameTransfers.openFirewall = true;
          extest.enable = true;
        };
      };
  };
}
