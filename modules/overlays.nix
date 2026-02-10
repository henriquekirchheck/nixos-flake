{ den, inputs, ... }:
{
  flake-file.inputs.nur = {
    url = "github:nix-community/NUR";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-parts.follows = "flake-parts";
  };
  den.default.includes = [ (den.aspects.utils._.nixpkgs._.add-overlay inputs.nur.overlays.default) ];
}
