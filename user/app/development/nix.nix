{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [ nixd nixpkgs-fmt ];
}
