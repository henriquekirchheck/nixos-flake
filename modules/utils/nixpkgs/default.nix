{
  # TODO: make more generic like unfree battery
  den.aspects.utils.provides.nixpkgs = {
    description = "nixpkgs Utilities";
    provides = {
      add-substituter =
        { substituter, public-key }:
        let
          nixConfig = {
            substituters = [ substituter ];
            trusted-substituters = [ substituter ];
            trusted-public-keys = [ public-key ];
          };
        in
        {
          nixos.nix.settings = nixConfig;
          homeManager.nix.settings = nixConfig;
        };
      add-overlay = overlay: {
        nixos.nixpkgs.overlays = [ overlay ];
        homeManager.nixpkgs.overlays = [ overlay ];
      };
    };
  };
}
