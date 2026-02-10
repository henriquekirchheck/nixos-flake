{
  den.aspects.apps.provides.sh.provides.bash = {
    description = "Bourne Again Shell";

    nixos.programs.bash.enable = true;
    homeManager.programs.bash = {
      enable = true;
      enableCompletion = true;
    };
  };
}
