{
  inputs,
  lib,
  __findFile,
  ...
}:
{
  den.aspects.themes.catppuccin = {
    includes = [ <stylix/module> ];
    nixos = { config, pkgs, ... }: {
      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
        polarity = "dark";
        opacity = {
          terminal = 0.75;
          applications = 0.98;
          popups = 0.75;
          desktop = 0.75;
        };
        cursor = {
          package = pkgs.phinger-cursors;
          name = "phinger-cursors-dark";
          size = 24;
        };
        icons = {
          enable = true;
          package = pkgs.papirus-icon-theme;
          dark = "Papirus-Dark";
          light = "Papirus-Light";
        };
        fonts = {
          serif = config.stylix.fonts.sansSerif;
          sansSerif = {
            package = pkgs.roboto;
            name = "Roboto";
          };
          monospace = {
            package = pkgs.nerd-fonts.jetbrains-mono;
            name = "JetBrainsMono Nerd Font";
          };
          emoji = {
            package = pkgs.noto-fonts-color-emoji;
            name = "Noto Color Emoji";
          };
        };
      };
    };
  };
}
