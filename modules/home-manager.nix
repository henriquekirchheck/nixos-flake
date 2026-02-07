{ den, ... }:
{
  den.default.includes = [ den._.home-manager ];
  flake-file.inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };
}
