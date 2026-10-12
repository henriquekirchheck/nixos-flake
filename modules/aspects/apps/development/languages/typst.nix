{
  den.aspects.apps.development.languages.typst = {
    homeManager = { pkgs, ... }: {
      home.packages = [
        pkgs.typst
        pkgs.tinymist
        pkgs.typstyle
      ];
    };
    zen-extensions = _: [ "typst" ];
  };
}
