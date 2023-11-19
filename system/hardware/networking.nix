{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;
  services.zerotierone.enable = true;
}