{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    fnm
    bun
    nodejs_20
    nodePackages.pnpm
  ];
}