{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [ nil ];
  programs.vscode.extensions = with pkgs.open-vsx; [
    jnoortheen.nix-ide
  ];
}