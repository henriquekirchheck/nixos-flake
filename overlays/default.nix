{ lib, inputs }:

map (v: import ./${v} inputs) (
  builtins.attrNames (lib.attrsets.filterAttrs (n: v: n != "default.nix") (builtins.readDir ./.))
)
