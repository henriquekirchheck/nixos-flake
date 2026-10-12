{
  den.aspects.apps.development.languages.godot = {
    homeManager = { pkgs, ... }: {
      home.packages = [
        pkgs.godot
        pkgs.gdscript-formatter
      ];
    };
    zed-extensions = _: [ "gdscript" ];
    zed-settings = _: [
      {
        languages."GDScript" = {
          formatter.external.command = "gdscript-formatter";
        };
      }
    ];
    persistHome = _: {
      directories = [
        ".config/godot"
        ".local/share/godot"
      ];
    };
  };
}
