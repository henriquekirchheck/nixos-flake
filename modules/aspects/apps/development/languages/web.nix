{
  den.aspects.apps.development.languages.web = {
    homeManager = { pkgs, ... }: {
      home.packages = [
        pkgs.oxlint
        pkgs.oxfmt
        pkgs.biome
        pkgs.emmet-language-server
      ];
    };
    zed-extensions = _: [
      "html"
      "emmet"
      "biome"
      "oxc"
    ];
  };
}
