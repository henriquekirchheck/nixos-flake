{
  inputs,
  den,
  lib,
  ...
}:
{
  flake-file.inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.schema.host = {
    options.sharedHomePkgs = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  den.aspects.home-manager = {
    os.nix = {
      registry.home-manager.flake = inputs.home-manager;
      settings.nix-path = [ "home-manager=flake:home-manager" ];
    };

    homeManager =
      {
        host,
        nixpkgs-overlays,
        lib,
        ...
      }:
      lib.mkMerge [
        (lib.mkIf (!host.sharedHomePkgs) {
          nixpkgs.overlays = lib.unique nixpkgs-overlays;
        })
      ];
  };

  den.aspects.home-manager.shared.os = { host, ... }: {
    home-manager.useGlobalPkgs = host.sharedHomePkgs;
    home-manager.useUserPackages = true;
  };
  den.schema.host.includes = [
    den.aspects.home-manager
    den.aspects.home-manager.shared
  ];

  den.policies.project-user-overlays =
    { user, host, ... }:
    lib.optionals host.sharedHomePkgs [
      (den.lib.policy.pipe.from "nixpkgs-overlays" [ den.lib.policy.pipe.expose ])
    ]
    ++ [ (den.lib.policy.pipe.from "nixpkgs-substituters" [ den.lib.policy.pipe.expose ]) ];
  den.schema.user.includes = [ den.policies.project-user-overlays ];
}
