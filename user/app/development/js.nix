{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    bun
    nodejs_21
  ];
}