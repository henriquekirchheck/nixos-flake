{
  den.aspects.apps.provides.fonts.nixos =
    { pkgs, ... }:
    {
      fonts = {
        fontDir.enable = true;
        enableDefaultPackages = true;
        packages =
          (with pkgs; [
            noto-fonts
            noto-fonts-cjk-sans
            noto-fonts-color-emoji
            roboto
            roboto-serif
            liberation_ttf
            freefont_ttf
            dejavu_fonts
            unifont
            material-symbols
          ])
          ++ (builtins.attrValues {
            inherit (pkgs.nerd-fonts)
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
      };
    };
}
