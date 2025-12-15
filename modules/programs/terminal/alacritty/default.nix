{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty-graphics;
    theme = "catppuccin_mocha";
    settings = {
      window = {
        decorations = "None";
        opacity = 0.75;
      };
      scrolling.history = 100000;
      font = {
        normal.family = "JetBrainsMono Nerd Font";
        size = 12;
      };
      cursor = {
        style = {
          shape = "Beam";
          blinking = "On";
        };
        vi_mode_style = {
          shape = "Block";
          blinking = "On";
        };
        unfocused_hollow = true;
      };
      keyboard.bindings = [
        {
          key = "N";
          mods = "Control | Alt";
          action = "CreateNewWindow";
        }
      ];
    };
  };
}
