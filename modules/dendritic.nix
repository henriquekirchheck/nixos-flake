{ inputs, ... }:
{
  imports = [
    inputs.flake-file.flakeModules.dendritic
    inputs.den.flakeModules.dendritic
  ];

  flake-file = {
    description = "My Awesome Flake";
    inputs = {
      flake-file.url = "github:vic/flake-file";
      den.url = "github:vic/den";
      nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };
  };
}
