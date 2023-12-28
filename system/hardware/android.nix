{ config, pkgs, lib, username, ... }:

{
  programs.adb.enable = true;
  nixpkgs.config.android_sdk.accept_license = true;
  environment.systemPackages = [
    pkgs.androidsdk_9_0
  ];
  users.users.${username}.extraGroups = ["adbusers"];
}
