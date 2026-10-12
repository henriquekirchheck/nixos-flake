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
    };
}
