{
  den.aspects.apps.provides.development.provides.languages.provides.python.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        python3
        uv
        ruff
        ty
      ];
    };
}
