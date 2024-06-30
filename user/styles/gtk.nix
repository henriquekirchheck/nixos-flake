{ config, pkgs, lib, ... }:
let
  cfg = {
    flavor = "mocha";
    accent = "sapphire";
    size = "compact";
    tweaks = [ "black" ];
  };
  gtkTweaks = lib.concatStringsSep "," cfg.tweaks;
  gtk4Dir =
    "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0";
  themePackage = pkgs.catppuccin-gtk.override {
    accents = [ cfg.accent ];
    inherit (cfg) size tweaks;
    variant = cfg.flavor;
  };
  themeName = "catppuccin-${cfg.flavor}-${cfg.accent}-${cfg.size}+${gtkTweaks}";
in {
  gtk = {
    enable = true;
    theme = {
      package = themePackage;
      name = themeName;
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };
  xdg.configFile = {
    "gtk-4.0/assets".source = "${gtk4Dir}/assets";
    "gtk-4.0/gtk.css".source = "${gtk4Dir}/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${gtk4Dir}/gtk-dark.css";
  };
}
