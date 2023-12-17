{ config, pkgs, lib, ... }:

{
  services.xserver.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  programs.dconf.enable = true;

  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    oxygen
    khelpcenter
    konsole
  ];

  services.xserver.displayManager.lightdm = {
    enable = lib.mkForce true;
    greeters.pantheon.enable = true;
    background = pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath;
  };
}