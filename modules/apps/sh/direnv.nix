{
  den.aspects.apps.provides.sh.provides.direnv = {
    description = "Direnv";

    homeManager.programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
