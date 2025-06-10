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
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      disko,
      sops-nix,
      ...
    }:
    let
      hosts = nixpkgs.lib.attrsets.filterAttrs (n: v: v == "directory") (builtins.readDir ./hosts);
    in
    {
      nixosConfigurations = builtins.mapAttrs (
        host: _:
        nixpkgs.lib.nixosSystem rec {
          pkgs = import nixpkgs {
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
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = specialArgs;
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
                users.users = import (builtins.mapAttrs (n: v: v + /account.nix) users) pkgs;
                home-manager.users = import (builtins.mapAttrs (n: v: v + /home.nix) users);
              }
            )
          ];
        }
      ) hosts;
    };
}
