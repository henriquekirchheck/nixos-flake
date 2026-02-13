{ den, inputs, ... }:
{
  imports = [
    inputs.flake-file.flakeModules.dendritic
    inputs.den.flakeModules.dendritic
  ];

  den.default.includes = [(den.aspects.utils._.nixpkgs._.add-substituter { substituter = "https://cache.nixos.org/"; public-key = "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="; })];

  flake-file = {
    description = "My Awesome Flake";
    inputs = {
      flake-file.url = "github:vic/flake-file";
      den.url = "github:vic/den";
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    };
  };
}
