{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    (blender.override {
      cudaSupport = true;
    })
  ];
}
