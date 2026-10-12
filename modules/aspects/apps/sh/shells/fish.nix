{
  den.aspects.apps.sh.shells.fish = {
    nixos.programs.fish = {
      enable = true;
      generateCompletions = true;
      vendor = {
        config.enable = true;
        functions.enable = true;
        completions.enable = true;
      };
    };
    homeManager = { pkgs, ... }: {
      programs.fish = {
        enable = true;
        generateCompletions = true;
        preferAbbrs = true;

        # Disable greeting
        interactiveShellInit = ''
          set fish_greeting
        '';

        plugins = [
          {
            name = "bang-bang";
            src = pkgs.fishPlugins.bang-bang.src;
          }
          {
            name = "pisces";
            src = pkgs.fishPlugins.pisces.src;
          }
          {
            name = "colored-man-pages";
            src = pkgs.fishPlugins.colored-man-pages.src;
          }
          {
            name = "fish-you-should-use";
            src = pkgs.fishPlugins.fish-you-should-use.src;
          }
        ];
      };
    };
  };
}
