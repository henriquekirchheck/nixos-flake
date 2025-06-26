{ pkgs, ... }:
let
  catppuccinOptions = {
    accent = "sapphire";
    variant = "mocha";
  };
  catppuccinName = "catppuccin-${catppuccinOptions.variant}-${catppuccinOptions.accent}";
  catppuccinTheme = pkgs.catppuccin-kvantum.override catppuccinOptions;
in
{
  qt = {
    enable = true;
    style.name = "kvantum";
  };
  xdg.configFile = {
    "Kvantum/${catppuccinName}".source = "${catppuccinTheme}/share/Kvantum/${catppuccinName}";
    "Kvantum/kvantum.kvconfig".text = "[General]\ntheme=${catppuccinName}";
  };
}
