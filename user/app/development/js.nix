{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    bun
    nodejs_latest
    nodePackages.pnpm
    biome
  ];
}
