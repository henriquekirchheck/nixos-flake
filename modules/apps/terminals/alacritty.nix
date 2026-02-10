{
  den.aspects.apps.provides.terminals.provides.alacritty.homeManager =
    { pkgs, ... }:
    {
      programs.alacritty = {
        enable = true;
        package = pkgs.alacritty-graphics;
        settings = {
          window.decorations = "None";
          scrolling.history = 100000;
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
    };
}
