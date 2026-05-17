{ den, ... }:
{
  flake-file.inputs.systems.url = "github:nix-systems/default";
  systems = builtins.attrNames den.hosts;
}
