{ config, pkgs, lib, username, ... }:

{
  programs.adb.enable = true;
  environment.systemPackages = [ pkgs.android-studio ];
  users.users.${username}.extraGroups = [ "adbusers" ];
}
