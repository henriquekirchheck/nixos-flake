{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    systems.url = "github:nix-systems/default-linux";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay.url = "github:nix-community/emacs-overlay";

    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-ld = {
      url = "github:nix-community/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions?ref=pull/161/head";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri-caelestia-shell = {
      url = "github:jutraim/niri-caelestia-shell";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        quickshell.follows = "quickshell";
      };
    };
    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.dgop.follows = "dgop";
    };

    blender-bin = {
      url = "github:edolstra/nix-warez?dir=blender";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nix-on-droid,
      disko,
      systems,
      treefmt-nix,
      sops-nix,
      ...
    }:
    let
      mkPkgs =
        {
          system,
          extraOverlays ? [ ],
        }:
        import nixpkgs {
          inherit system;
          overlays =
            ((import ./overlays) {
              inherit inputs;
              inherit (nixpkgs) lib;
            })
            ++ extraOverlays;
          config = {
            allowUnfree = true;
            allowUnfreePredicate = _: true;
            android_sdk.accept_license = true;
            microsoftVisualStudioLicenseAccepted = true;
          };
        };

      inherit (nixpkgs) lib;
      forAllSystems =
        f:
        lib.genAttrs (import systems) (
          system:
          f (mkPkgs {
            inherit system;
          })
        );

      treefmt' = forAllSystems (pkgs: treefmt-nix.lib.evalModule pkgs ./treefmt.nix);
    in
    {
      nixosConfigurations =
        let
          hosts = nixpkgs.lib.attrsets.filterAttrs (n: v: v == "directory") (builtins.readDir ./hosts);
        in
        builtins.mapAttrs (
          host: _:
          nixpkgs.lib.nixosSystem rec {
            pkgs = mkPkgs { inherit system; };
            system = import ./hosts/${host}/system.nix;
            specialArgs = { inherit inputs; };
            modules = [
              ./hosts/${host}/hardware-configuration.nix
              ./hosts/${host}/configuration.nix
              disko.nixosModules.disko
              ./hosts/${host}/disko.nix
              sops-nix.nixosModules.sops
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = specialArgs;
                  sharedModules = [ sops-nix.homeManagerModules.sops ];
                };
              }
              (
                let
                  users = builtins.listToAttrs (
                    map (user: {
                      name = user;
                      value = ./users/${user};
                    }) (import ./hosts/${host}/users.nix)
                  );
                in
                {
                  imports = map (v: v + /account.nix) (builtins.attrValues users);
                  home-manager.users = builtins.mapAttrs (_: v: v + /home.nix) users;
                }
              )
            ];
          }
        ) hosts;

      homeConfigurations =
        let
          users = nixpkgs.lib.attrsets.filterAttrs (n: v: v == "directory") (builtins.readDir ./users);
        in
        builtins.mapAttrs (
          user: _:
          home-manager.lib.homeManagerConfiguration {
            pkgs = mkPkgs { system = builtins.currentSystem; };
            modules = [ ./users/${user}/home.nix ];
            extraSpecialArgs = { inherit inputs; };
          }
        ) users;

      nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
        modules = [
          ./android/configuration.nix
          {
            home-manager = {
              useGlobalPkgs = true;
              #config = import ./android/home.nix;
            };
          }
        ];
        extraSpecialArgs = { inherit inputs; };
        pkgs = mkPkgs {
          system = builtins.currentSystem;
          extraOverlays = [ nix-on-droid.overlays.default ];
        };
        home-manager-path = home-manager.outPath;
      };

      formatter = forAllSystems (pkgs: treefmt'.${pkgs.stdenv.hostPlatform.system}.config.build.wrapper);
      checks = forAllSystems (pkgs: {
        formatting = treefmt'.${pkgs.stdenv.hostPlatform.system}.config.build.check self;
      });
    };
}
