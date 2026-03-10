{ lib, inputs, ... }:
{
  flake-file.inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];
  den.ctx.user.includes = [ { nixos.imports = [ inputs.home-manager.nixosModules.default ]; } ];
  imports = [ inputs.home-manager.flakeModules.home-manager ];
}
