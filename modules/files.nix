{ inputs, ... }:
{
  flake-file.inputs.files.url = "github:mightyiam/files";
  imports = [ inputs.files.flakeModules.default ];
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
          path_ = ".gitignore";
          drv = pkgs.writeText "gitignore" ''
            /result
            .direnv/
            .pre-commit-config.yaml
          '';
        }
        {
          path_ = ".envrc";
          drv = pkgs.writeText "envrc" ''
            use flake
          '';
        }
        {
          path_ = "README.md";
          drv = pkgs.writeText "README.md" ''
            # Dentritic NixOS Configuration
          '';
        }
      ];
    };
}
