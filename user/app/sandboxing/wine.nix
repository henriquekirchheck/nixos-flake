{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    wineWowPackages.staging
    bottles
    dosfstools
  ];
}