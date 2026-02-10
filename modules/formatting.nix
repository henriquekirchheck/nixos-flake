{ inputs, ... }:
{
  flake-file.inputs.treefmt-nix = {
    url = "github:numtide/treefmt-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake-file.formatter = pkgs: pkgs.nixfmt;

  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem = {
    treefmt = {
      programs.shfmt.enable = true;
      programs.shellcheck.enable = true;
      programs.nixfmt.enable = true;
      programs.yamlfmt.enable = true;
      programs.statix.enable = true;
      settings.excludes = [ ".envrc" ];
    };
  };
}
