{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    rustup
    pkg-config
  ];
}
