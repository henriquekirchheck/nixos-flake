{ pkgs, ... }:
{
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      monospace = [ "JetBrainsMono Nerd Font" ];
      sansSerif = [ "Roboto" ];
      serif = [ "Roboto Serif" ];
    };
  };

}
