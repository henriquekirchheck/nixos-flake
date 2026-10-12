{
  __findFile,
  inputs,
  withSystem,
  ...
}:
{
  flake-file.inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-lib.follows = "nixpkgs";
  };

  den.quirks = {
    nixpkgs-overlays.description = "nixpkgs overlays collected from aspects";
    nixpkgs-substituters.description = "substituters collected from aspects";
  };

  den.default.includes = [ <nixpkgs> ];
  den.aspects.nixpkgs = {
    includes = [
      <nixpkgs/collectOverlays>
      <nixpkgs/collectSubstituters>
    ];

    nixpkgs-overlays = _: [
      # this flake's own packages, as pkgs.local
      (final: _prev: {
        local = withSystem final.stdenv.hostPlatform.system ({ config, ... }: config.packages);
      })
    ];
    nixpkgs-substituters = _: [
      {
        substituter = "https://cache.nixos.org/";
        public-key = "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=";
      }
    ];

    os = { lib, ... }: {
      nixpkgs.config.nvidia.acceptLicense = true;
      nix = {
        registry.nixpkgs.flake = inputs.nixpkgs;
        settings.nix-path = [
          "nixpkgs=flake:nixpkgs"
          "${inputs.nixpkgs}"
        ];
      };
    };
  };

  den.aspects.nixpkgs.collectOverlays = {
    os = { lib, nixpkgs-overlays, ... }: {
      nixpkgs.overlays = lib.unique nixpkgs-overlays;
    };
  };
  den.aspects.nixpkgs.collectSubstituters = {
    os =
      {
        config,
        lib,
        nixpkgs-substituters,
        ...
      }:
      {
        options.substituters = lib.mkOption {
          type = lib.types.listOf (
            lib.types.submodule {
              options = {
                substituter = lib.mkOption {
                  type = lib.types.str;
                };
                public-key = lib.mkOption {
                  type = lib.types.str;
                };
              };
            }
          );
          default = nixpkgs-substituters;
        };
        config.nix.settings = {
          substituters = lib.unique (lib.map (e: e.substituter) config.substituters);
          trusted-public-keys = lib.unique (lib.map (e: e.public-key) config.substituters);
        };
      };
  };
}
