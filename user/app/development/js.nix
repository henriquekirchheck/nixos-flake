{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    bun
    nodejs_21
    nodePackages.pnpm
    biome
  ];
}
