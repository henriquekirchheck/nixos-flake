{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    blender_4_0
  ];
}
