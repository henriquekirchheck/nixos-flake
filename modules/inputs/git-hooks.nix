{ den, inputs, ... }:
{
  flake-file.inputs.git-hooks-nix = {
    url = "github:cachix/git-hooks.nix";
    inputs = {
      nixpkgs.follows = "nixpkgs";
      flake-compat.follows = "";
    };
  };
  imports = [ inputs.git-hooks-nix.flakeModule ];

  den.aspects.git-hooks-nix.nixpkgs-substituters = [
    {
      substituter = "https://pre-commit-hooks.cachix.org";
      public-key = "pre-commit-hooks.cachix.org-1:Pkk3Panw5AW24TOv6kz3PvLhlH8puAsJTBbOPmBo7Rc=";
    }
  ];
  den.default.includes = [ den.aspects.git-hooks-nix ];

  perSystem =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      pre-commit = {
        settings = {
          package = pkgs.prek;
          hooks = {
            nixfmt.enable = true;
            statix.enable = false;
            deadnix.enable = false;
            flake-checker.enable = true;

            shfmt.enable = true;
            shellcheck.enable = true;

            check-toml.enable = true;
            check-xml.enable = true;
            check-yaml.enable = true;
            yamlfmt.enable = true;
          };
        };
        check.enable = true;
      };
      devShells.default = config.pre-commit.devShell;
      formatter = pkgs.writeShellScriptBin "pre-commit-run" ''
        ${lib.getExe config.pre-commit.settings.package} run --all-files --config ${config.pre-commit.settings.configPath}
      '';
    };
}
