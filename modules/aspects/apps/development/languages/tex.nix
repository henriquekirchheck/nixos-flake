{
  den.aspects.apps.development.languages.tex = {
    homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.tectonic ];
    };
    zen-extensions = _: [ "latex" ];
  };
}
