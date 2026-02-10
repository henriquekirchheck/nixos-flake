{ inputs, ... }:
{
  flake-file.inputs.blender-bin = {
    url = "github:edolstra/nix-warez?dir=blender";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.apps.provides.media.provides.models.provides.blender = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ inputs.blender-bin.packages.${pkgs.stdenv.hostPlatform.system}.default ];
      };
  };
}
