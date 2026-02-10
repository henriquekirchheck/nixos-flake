{
  den.aspects.apps.provides.development.provides.languages.provides.nix.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        nixd
        nixfmt
      ];
    };
}
