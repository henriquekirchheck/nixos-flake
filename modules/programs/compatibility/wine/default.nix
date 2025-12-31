{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wineWowPackages.full
    winetricks
  ];
}
