{ inputs, ... }:
{
  flake-file.inputs.files = {
    url = "github:mightyiam/files";
    inputs = {
      nixpkgs.follows = "nixpkgs";
      flake-parts.follows = "flake-parts";
      git-hooks.follows = "git-hooks-nix";
      import-tree.follows = "import-tree";
      treefmt-nix.follows = "treefmt-nix";
      systems.follows = "systems";
    };
  };

  imports = [ (inputs.files + "/flake-module.nix") ];
  perSystem =
    { config, pkgs, ... }:
    {
      apps.write-files = {
        type = "app";
        program = "${config.files.writer.drv}/bin/write-files";
        meta.description = "Write all files managed by nix";
      };
      files.files = [
        {
          path = ".gitignore";
          drv = pkgs.writeText "gitignore" ''
            /result
            .direnv/
            .pre-commit-config.yaml
          '';
        }
        {
          path = ".envrc";
          drv = pkgs.writeText "envrc" ''
            use flake
          '';
        }
        {
          path = "README.md";
          drv = pkgs.writeText "README.md" ''
            # Dentritic NixOS Configuration
          '';
        }
      ];
    };
}
