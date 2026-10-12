{
  den.aspects.apps.development.languages.markdown = {
    homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.rumdl ];
    };
    zen-extensions = _: [ "rumdl" ];
  };
}
