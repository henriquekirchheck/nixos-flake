{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [ yuzu-early-access ];
}