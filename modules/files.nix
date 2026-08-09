{ inputs, ... }:
{
  flake-file.inputs.files = {
    url = "github:mightyiam/files";
    flake = false;
  };

  imports = [ (inputs.files + "/flake-module.nix") ];
  perSystem =
    { config, ... }:
    {
      apps.write-files = {
        type = "app";
        program = "${config.files.writer.drv}/bin/write-files";
        meta.description = "Write all files managed by nix";
      };
      files.file = {
        ".gitignore".text = ''
          /result
          .direnv/
          .pre-commit-config.yaml
        '';
        ".envrc".text = ''
          # shellcheck shell=bash
          use flake
        '';
        "README.md".text = ''
          # Dentritic NixOS Configuration
        '';
      };
    };
}
