{ pkgs, ... }:
{
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [ pkgs.noto-fonts-emoji ];
      monospace = [ pkgs.nerd-fonts.jetbrains-mono ];
      sansSerif = [ pkgs.roboto ];
      serif = [ pkgs.roboto-serif ];
    };
  };

}
