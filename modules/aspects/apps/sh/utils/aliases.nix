{
  den.aspects.apps.sh.utils.aliases = {
    homeManager.home.shellAliases = {
      ls = "eza -al --color=always --group-directories-first --icons=always";
      la = "eza -a --color=always --group-directories-first --icons=always";
      ll = "eza -l --color=always --group-directories-first --icons=always";
      lt = "eza -aT --color=always --group-directories-first --icons=always";

      grep = "grep --color=auto";
      cp = "cp -i";
      mv = "mv -i";
      cat = "bat";
    };
  };
}
