{
  den.aspects.apps.provides.wine = {
    description = "Wine Is Not an Emulator";

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          wineWow64Packages.full
          winetricks
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
