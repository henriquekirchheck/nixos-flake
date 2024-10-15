{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    bun
    deno
    nodejs_latest
    nodePackages.pnpm
    biome
  ];
}
