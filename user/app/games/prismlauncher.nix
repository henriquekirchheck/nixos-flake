{ config, pkgs, lib, ... }:
let
  launcher = (pkgs.prismlauncher.override {
    glfw = pkgs.glfw-wayland-minecraft;
    gamemodeSupport = true;
  });
in { home.packages = [ launcher ]; }
