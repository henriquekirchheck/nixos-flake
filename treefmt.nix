# treefmt.nix
_: {
  projectRootFile = "flake.nix";
  programs.shfmt.enable = true;
  programs.shellcheck.enable = true;
  programs.nixfmt.enable = true;
  programs.yamlfmt.enable = true;
  programs.statix.enable = true;
}
