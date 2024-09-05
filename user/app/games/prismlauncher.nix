{ config, pkgs, lib, ... }:
let
  launcher = (pkgs.prismlauncher.override {
    gamemodeSupport = true;
  });
in { home.packages = [ launcher ]; }
