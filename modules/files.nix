{ inputs, ... }:
{
  flake-file.inputs.files.url = "github:mightyiam/files";
  imports = [ inputs.files.flakeModules.default ];
  perSystem =
    { config, pkgs, ... }:
    let
      checkout = [
        {
          name = "Install Node";
          run = "nix profile add nixpkgs#nodejs_latest";
        }
        { uses = "https://data.forgejo.org/actions/checkout@v6"; }
      ];
      cache = [
        {
          name = "Install Needed Packages";
          run = "nix profile add github:juspay/omnix github:juspay/cachix-push nixpkgs#cachix";
        }
        {
          name = "Setup Cachix";
          run = ''
            CACHES=(
              'henriquekh'
              'nix-community'
              'hyprland'
              'niri'
            )
            for cache in ''${CACHES[@]}; do
              cachix use $cache
            done
          '';
        }
        {
          name = "Build output";
          run = "om ci run --results=/om.json";
        }
        {
          name = "Push to cache";
          run = ''cachix-push-om-outputs -c henriquekh --subflake ROOT --prefix "''$(git rev-parse --short HEAD)" < /om.json'';
        }
      ];
    in
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
        {
          path_ = ".forgejo/workflows/check.yml";
          drv = pkgs.writers.writeJSON "fj-actions-workflow-check.yaml" {
            on = {
              push.branches = [ "main" ];
              workflow_dispatch = { };
            };
            env.CACHIX_AUTH_TOKEN = "\${{ secrets.CACHIX_AUTH_TOKEN }}";
            jobs.check = {
              runs-on = "nixos-unstable";
              steps =
                checkout
                ++ [
                  { run = "nix -Lv flake check --all-systems"; }
                ]
                ++ cache;
            };
          };
        }
        {
          path_ = ".forgejo/workflows/update.yml";
          drv = pkgs.writers.writeJSON "fj-actions-workflow-update.yaml" {
            on = {
              schedule = [ { cron = "15 4 * * *"; } ];
              workflow_dispatch = { };
            };
            env.CACHIX_AUTH_TOKEN = "\${{ secrets.CACHIX_AUTH_TOKEN }}";
            jobs.check = {
              runs-on = "nixos-unstable";
              steps =
                checkout
                ++ [
                  { run = "nix flake update"; }
                  { run = "git add flake.lock"; }
                  { run = "nix -Lv flake check --all-systems"; }
                ]
                ++ cache
                ++ [
                  {
                    name = "Push new flake.lock";
                    run = ''
                      git config --global user.name "flake-update[bot]"
                      git config --global user.email "<>"
                      git commit -m "Update Flake Inputs: $(date +%F)"
                      git push
                    '';
                  }
                ];
            };
          };
        }
      ];
    };
}
