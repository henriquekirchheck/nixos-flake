{
  den.aspects.apps.provides.wine = {
    description = "Wine Is Not an Emulator";

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          wineWowPackages.full
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
