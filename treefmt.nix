# treefmt.nix
{ pkgs, ... }:
{
  projectRootFile = "flake.nix";
  programs.shfmt.enable = true;
  programs.nixfmt.enable = true;
  programs.yamlfmt.enable = true;
}
