{ pkgs, ... }:

{
  fonts.fontDir.enable = true;
  fonts.packages =
    with pkgs;
    [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      roboto
      roboto-serif
      liberation_ttf
      freefont_ttf
      dejavu_fonts
      unifont
      fira-code
      fira-code-symbols
      inconsolata
      iosevka
      jetbrains-mono
      meslo-lg
      ubuntu_font_family
      ibm-plex
      material-symbols
    ]
    ++ (builtins.attrValues {
      inherit (nerd-fonts)
        fira-code
        inconsolata
        iosevka
        jetbrains-mono
        meslo-lg
        roboto-mono
        ubuntu
        ubuntu-mono
        symbols-only
        ;
    });
}
