{ den, inputs, ... }:
{
  flake-file.inputs.git-hooks-nix = {
    url = "github:cachix/git-hooks.nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  imports = [ inputs.git-hooks-nix.flakeModule ];

  den.default.includes = [
    (den.aspects.utils._.nixpkgs._.add-substituter {
      substituter = "https://pre-commit-hooks.cachix.org";
      public-key = "pre-commit-hooks.cachix.org-1:Pkk3Panw5AW24TOv6kz3PvLhlH8puAsJTBbOPmBo7Rc=";
    })
  ];

  perSystem =
    { config, pkgs, ... }:
    {
      pre-commit = {
        settings = {
          package = pkgs.prek;
          hooks = {
            nix-fmt = {
              enable = true;
              name = "nix fmt";
              entry = "nix fmt";
              always_run = true;
              pass_filenames = false;
              types = [ ];
            };
            nix-check = {
              enable = true;
              name = "nix flake check";
              entry = "nix flake check";
              pass_filenames = false;
              after = [ "nix-fmt" ];
              types = [ ];
            };
          };
        };
        check.enable = false;
      };
      devShells.default = pkgs.mkShell {
        shellHook = ''
          ${config.pre-commit.shellHook}
        '';

        packages = [
          config.packages.write-flake
          config.packages.write-files
        ];
      };
    };
}
