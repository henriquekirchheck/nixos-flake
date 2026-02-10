{
  den.aspects.apps.provides.development.provides.game-engines.provides.godot.homeManager =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.godot ];
    };
}
