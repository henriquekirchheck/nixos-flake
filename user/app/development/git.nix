{ config, lib, pkgs, name, email, dotfilesDir, ... }:

{
  home.packages = with pkgs; [ git gh ];
  programs.git = {
    enable = true;
    userName = name;
    userEmail = email;
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = [ "${config.home.homeDirectory}/${dotfilesDir}/.git" ];
    };
  };
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      # Workaround for https://github.com/nix-community/home-manager/issues/4744
      version = 1;
    };
    gitCredentialHelper.enable = true;
  };
}
