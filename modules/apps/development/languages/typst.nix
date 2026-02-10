{
  den.aspects.apps.provides.development.provides.languages.provides.typst.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        typst
        typstyle
      ];
    };
}
