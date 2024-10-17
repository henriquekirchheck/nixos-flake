{ config, pkgs, lib, inputs, ... }:

{
  home.packages = with pkgs; [
    inputs.blender-bin.packages.${pkgs.system}.default
  ];
}
