{ input, pkgs, ... }:

{
  home.packages = [ input.quickshell.${pkgs.system}.default ];
}
