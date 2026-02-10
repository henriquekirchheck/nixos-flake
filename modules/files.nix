{ inputs, ... }:
{
  flake-file.inputs.files.url = "github:mightyiam/files";
  imports = [ inputs.files.flakeModules.default ];
  perSystem =
    { config, pkgs, ... }:
    {
      packages.write-files = config.files.writer.drv;
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
        {
          path_ = ".sops.yaml";
          drv = pkgs.writeText "sops.yaml" ''
            keys:
              - &henrique age1cmx764yuualp623t3urnuan747kpxpyacr7ghtsy5huwdqv6ps4qdw3xs6
              - &pc age189jem67f5uc8hwsrmc0ac2x3fxugucdclmhe4usjmjnydw03vufsx38w9c
              - &laptop age1kk0s3r3a7meuvz8xhr9nc2zrxx3v53rdf5y832y9fm6fq5v4x3dsmd8nss
            creation_rules:
              - path_regex: modules/hosts/pc/secrets/.*$
                key_groups:
                  - age:
                      - *henrique
                      - *pc
              - path_regex: modules/hosts/laptop/secrets/.*$
                key_groups:
                  - age:
                      - *henrique
                      - *laptop
              - path_regex: modules/users/henrique/secrets/.*$
                key_groups:
                  - age:
                      - *henrique
                      - *pc
                      - *laptop
          '';
        }
      ];
    };
}
