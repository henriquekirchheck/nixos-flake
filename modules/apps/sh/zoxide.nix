{
  den.aspects.apps.provides.sh.provides.zoxide = {
    description = "Zoxide";

    homeManager.programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
