{ config, lib, pkgs, ... }:

{
  imports = [ ../utils/electron.nix ];

  home.packages = [
    pkgs.vesktop
  ];
}