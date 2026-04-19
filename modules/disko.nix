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
      fromAspect = _: den.lib.parametric.fixedTo { inherit host; } host.aspect;
      guard = { options, ... }: options ? disko;
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
