{ den, inputs, ... }: {
  flake-file.inputs.fin = {
    url = "github:tsirysndr/fin";
    inputs = {
      nixpkgs.follows = "nixpkgs";
      flake-utils.follows = "flake-utils";
    };
  };
  den.default.includes = [
    (den.aspects.utils._.nixpkgs._.add-substituter {
      substituter = "https://tsirysndr.cachix.org/";
      public-key = "tsirysndr.cachix.org-1:fbGYj/T8+9oqrF2c3EaQ33lMqZdb5n81Mk2jRE+C4wA=";
    })
  ];

  den.aspects.apps.provides.media.provides.audio.provides.fin.homeManager =
    { pkgs, ... }:
    {
      home.packages = [ inputs.fin.packages.${pkgs.stdenv.hostPlatform.system}.default ];
    };
}
