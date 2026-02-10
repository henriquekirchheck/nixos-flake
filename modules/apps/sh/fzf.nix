{
  den.aspects.apps.provides.sh.provides.fzf = {
    description = "fuzzy finder";

    homeManager.programs.fzf = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
