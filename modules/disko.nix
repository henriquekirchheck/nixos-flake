{
  den,
  lib,
  inputs,
  ...
}:
let
  fwd =
    { host }:
    den.provides.forward {
      each = lib.singleton host;
      fromClass = _: "disko";
      intoClass = _: host.class;
      intoPath = _: [ "disko" ];
      guard = { options, ... }: options ? disko;
      fromAspect = _: den.aspects.${host.aspect};
    };
in
{
  flake-file.inputs.disko = {
    url = "github:nix-community/disko";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  den.ctx.host.includes = [
    fwd
    { nixos.imports = [ inputs.disko.nixosModules.disko ]; }
  ];
  den.schema.host.classes = lib.mkDefault [ "disko" ];
}
