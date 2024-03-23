{ config, pkgs, lib, ... }:
#let
#  themePackage = pkgs.catppuccin-gtk.override {
#    accents = [ "sapphire" ];
#    size = "compact";
#    variant = "mocha";
#    tweaks = [ "black" ];
#  };
#  themeName = "Catppuccin-Mocha-Compact-Sapphire-Dark";
#in 
{
  gtk = {
    #    enable = true;
    #    theme = {
    #      package = themePackage;
    #      name = themeName;
    #    };
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
  #  xdg.configFile = {
  #    "gtk-4.0/assets".source =
  #      "${themePackage}/share/themes/${themeName}/gtk-4.0/assets";
  #    "gtk-4.0/gtk.css".source =
  #      "${themePackage}/share/themes/${themeName}/gtk-4.0/gtk.css";
  #    "gtk-4.0/gtk-dark.css".source =
  #      "${themePackage}/share/themes/${themeName}/gtk-4.0/gtk-dark.css";
  #  };
}
