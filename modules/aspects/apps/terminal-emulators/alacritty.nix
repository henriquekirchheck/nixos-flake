{
  den.aspects.apps.terminal-emulators.alacritty = {
    homeManager = { pkgs, ... }: {
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

    niri-window-rules = _: [
      {
        matches = [ { app-id = "Alacritty"; } ];
        draw-border-with-background = false;
        background-effect.blur = true;
      }
    ];
  };
}
