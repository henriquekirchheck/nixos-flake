{
  den.aspects.apps.provides.fetch.provides.fastfetch = {
    homeManager = {
      programs.fastfetch = {
        enable = true;
        settings = builtins.fromJSON (builtins.readFile ./fastfetch.json);
      };
      programs.hyfetch.settings.backend = "fastfetch";
    };
  };
}
