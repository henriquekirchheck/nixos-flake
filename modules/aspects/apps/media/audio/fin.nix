{ inputs, ... }: {
  flake-file.inputs.fin = {
    url = "github:tsirysndr/fin";
    inputs = {
      nixpkgs.follows = "nixpkgs";
      flake-utils.follows = "flake-utils";
    };
  };

  den.aspects.apps.media.audio.fin = {
    homeManager = { pkgs, ... }: {
      home.packages = [ inputs.fin.packages.${pkgs.stdenv.hostPlatform.system}.default ];
    };

    nixpkgs-substituters = _: [
      {
        substituter = "https://tsirysndr.cachix.org/";
        public-key = "tsirysndr.cachix.org-1:fbGYj/T8+9oqrF2c3EaQ33lMqZdb5n81Mk2jRE+C4wA=";
      }
    ];

    persistHome = _: {
      directories = [ ".config/fin" ];
    };
  };
}
