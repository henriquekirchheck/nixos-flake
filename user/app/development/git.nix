{ config, lib, pkgs, name, email, ... }:

{
  home.packages = with pkgs; [ git gh ];
  programs.git.enable = true;
  programs.git.userName = name;
  programs.git.userEmail = email;
  programs.git.extraConfig = {
    init.defaultBranch = "main";
  };
}