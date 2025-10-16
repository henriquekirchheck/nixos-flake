{ lib, ... }:
{
  imports = map (v: ./${v}) (
    builtins.attrNames (lib.attrsets.filterAttrs (n: v: v == "directory") (builtins.readDir ./.))
  );
}
