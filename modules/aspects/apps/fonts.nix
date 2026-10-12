{ __findFile, ... }:
{
  den.default.includes = [ <apps/fonts> ];
  den.aspects.apps.fonts = {
    includes = [
      (<den/unfree> [
        "corefonts"
        "vista-fonts"
      ])
    ];

    nixos =
      { pkgs, ... }:
      {
        fonts = {
          fontDir.enable = true;
          enableDefaultPackages = true;
          packages = with pkgs; [
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
            nerd-fonts.jetbrains-mono

            # Fucking windows fonts
            corefonts
            vista-fonts
          ];
        };
      };
  };
}
