{ inputs, den, ... }:
{
  flake-file.inputs.disko = {
    url = "github:nix-community/disko";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.default.includes = [ den.aspects.disko ];
  den.aspects.disko = {
    os.nix = {
      registry.disko.flake = inputs.disko;
      settings.nix-path = [ "disko=flake:disko" ];
    };
  };
  den.aspects.disko.module = {
    nixos.imports = [ inputs.disko.nixosModules.disko ];
  };
}
