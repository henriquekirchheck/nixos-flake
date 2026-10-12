{
  den.aspects.apps.fetch.fastfetch = {
    homeManager = {
      programs.fastfetch = {
        enable = true;
        settings = builtins.fromJSON (builtins.readFile ./fastfetch.json);
      };
    };
  };
}
