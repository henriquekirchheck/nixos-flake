{
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
          nixos.nix.config = nixConfig;
          homeManager.nix.config = nixConfig;
        };
      add-overlay = overlay: {
        nixos.nixpkgs.overlays = [ overlay ];
        homeManager.nixpkgs.overlays = [ overlay ];
      };
    };
  };
}
