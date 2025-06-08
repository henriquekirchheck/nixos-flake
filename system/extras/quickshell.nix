{ pkgs, inputs, ... }:

{
  environment.systemPackages =
    [ inputs.quickshell.packages.${pkgs.system}.default ];
  qt.enable = true;
}
