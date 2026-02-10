{ den, ... }:
{
  den.aspects.apps.provides.development.provides.versioning.provides.jujutsu = {
    description = "Jujutsu VCS";
    homeManager.programs.jujutsu.enable = true;
    provides.include-settings = settings: {
      homeManager.programs.jujutsu.settings = settings;
    };
  };
}
