{
  den.aspects.apps.provides.wine = {
    description = "Wine Is Not an Emulator";

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          wineWow64Packages.waylandFull
          winetricks
          (writeShellScriptBin "wine64" ''exec wine "$@"'')
        ];
      };

    provides.bottles = {
      description = "Bottles";
      homeManager =
        { pkgs, ... }:
        {
          home.packages = with pkgs; [
            bottles
          ];
        };
    };
  };
}
