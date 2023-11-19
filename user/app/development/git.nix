{ config, lib, pkgs, name, email, ... }:

{
  home.packages = with pkgs; [ git gh ];
  programs.git = {
    enable = true;
    userName = name;
    userEmail = email;
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
    gitCredentialHelper.enable = true;
  };
}