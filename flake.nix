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
    systems.url = "github:nix-systems/default-linux";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
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

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };
    niri.url = "https://github.com/sodiboo/niri-flake";

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
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
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      disko,
      flake-utils,
      sops-nix,
      ...
    }:
    let
      mkPkgs =
        system:
        import nixpkgs {
          inherit system;
          overlays = (import ./overlays) {
            inherit inputs;
            inherit (nixpkgs) lib;
          };
          config = {
            allowUnfree = true;
            allowUnfreePredicate = _: true;
            android_sdk.accept_license = true;
          };
        };
    in
    {
      nixosConfigurations =
        let
          hosts = nixpkgs.lib.attrsets.filterAttrs (n: v: v == "directory") (builtins.readDir ./hosts);
        in
        builtins.mapAttrs (
          host: _:
          nixpkgs.lib.nixosSystem rec {
            pkgs = mkPkgs system;
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
    }
    // (flake-utils.lib.eachDefaultSystemPassThrough (system: {
      homeConfigurations =
        let
          users = nixpkgs.lib.attrsets.filterAttrs (n: v: v == "directory") (builtins.readDir ./users);
        in
        builtins.mapAttrs (
          user: _:
          home-manager.lib.homeManagerConfiguration {
            pkgs = mkPkgs system;
            modules = [ ./users/${user}/home.nix ];
            extraSpecialArgs = { inherit inputs; };
          }
        ) users;
    }))
    // (flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = mkPkgs system;
      in
      {
        formatter = pkgs.nixfmt-tree;
        devShells.default = pkgs.mkShell {
          inputsFrom = [ inputs.quickshell.packages.${system}.default ];
          buildInputs = [
            inputs.quickshell.packages.${system}.default
            pkgs.qt6.full
          ];
          shellHook = ''
            export QML2_IMPORT_PATH="${
              inputs.quickshell.packages.${system}.default
            }/${pkgs.qt6.qtbase.qtQmlPrefix}:${pkgs.qt6.full}/${pkgs.qt6.qtbase.qtQmlPrefix}:$QML2_IMPORT_PATH"
            export QT_PLUGIN_PATH="${pkgs.qt6.full}/${pkgs.qt6.qtbase.qtPluginPrefix}:$QT_PLUGIN_PATH"
          '';
        };
      }
    ));
}
