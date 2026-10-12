{ __findFile, inputs, ... }:
{
  flake-file.inputs.stylix = {
    url = "github:nix-community/stylix";
    inputs = {
      nixpkgs.follows = "nixpkgs";
      flake-parts.follows = "flake-parts";
      nur.follows = "nur";
      systems.follows = "systems";
    };
  };

  den.default.includes = [ <stylix> ];
  den.aspects.stylix = {
    nixos.nix = {
      registry.stylix.flake = inputs.stylix;
      settings.nix-path = [ "disko=flake:stylix" ];
    };
  };
  den.aspects.stylix.module = {
    nixos.imports = [ inputs.stylix.nixosModules.stylix ];
  };
  den.aspects.stylix.disable = {
    homeManager.stylix.enable = false;
  };
}
