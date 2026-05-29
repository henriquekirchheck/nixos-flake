{ inputs, ... }:
{
  flake-file.inputs.files = {
    url = "github:mightyiam/files";
    flake = false;
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
      files.file = {
        ".gitignore".text = ''
          /result
          .direnv/
          .pre-commit-config.yaml
        '';
        ".envrc".text = ''
          use flake
        '';
        "README.md".text = ''
          # Dentritic NixOS Configuration
        '';
      };
    };
}
