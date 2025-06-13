{
  pkgs,
  lib,
  ...
}:
let
  cfg = {
    flavor = "mocha";
    accent = "sapphire";
    size = "compact";
    tweaks = [ "black" ];
  };
  gtkTweaks = lib.concatStringsSep "," cfg.tweaks;
  themePackage = pkgs.catppuccin-gtk.override {
    accents = [ cfg.accent ];
    inherit (cfg) size tweaks;
    variant = cfg.flavor;
  };
  themeName = "catppuccin-${cfg.flavor}-${cfg.accent}-${cfg.size}+${gtkTweaks}";
in
{
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
}
