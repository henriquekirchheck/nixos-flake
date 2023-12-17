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
    greeters.slick = {
      enable = true;
      theme = {
        package = pkgs.catppuccin-gtk.override {
          accents = [ "sapphire" ];
          size = "compact";
          variant = "mocha";
          tweaks = [ "black" ];
        };
        name = "Catppuccin-Mocha-Compact-Sapphire-Dark";
      };
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };
      cursorTheme = {
        package = pkgs.phinger-cursors;
        name = "phinger-cursors-light";
        size = 24;
      };
    };
    background = pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath;
  };
}