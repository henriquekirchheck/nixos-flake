{ __findFile, ... }:
{
  den.default.includes = [ <apps/sh/shells/bash> ];
  den.aspects.apps.sh.shells.bash = {
    nixos.programs.bash = {
      enable = true;
      completion.enable = true;
    };
    homeManager.programs.bash = {
      enable = true;
      enableCompletion = true;
      historyControl = [
        "erasedups"
        "ignoredups"
        "ignorespace"
        "ignoreboth"
      ];
      historyFileSize = 100000;
    };
  };
}
