{ den, ... }:
{
  den.aspects.services.provides.forgejo-runner = {
    description = "Forgejo Actions Runner";

    nixos =
      { pkgs, ... }:
      {
        services.gitea-actions-runner.package = pkgs.forgejo-runner;
      };

    provides = {
      addInstance =
        {
          name,
          url,
          labels ? [
            "docker:docker://node:22-bookworm"

            "debian-latest:docker://debian:bookworm"
            "debian-bookworm:docker://debian:bookworm"
            "debian-sid:docker://debian:sid"

            "ubuntu-latest:docker://ubuntu:latest"
            "ubuntu-rolling:docker://ubuntu:rolling"
            "ubuntu-25.10:docker://ubuntu:questing"
            "ubuntu-24.04:docker://ubuntu:noble"
            "ubuntu-22.04:docker://ubuntu:jammy"

            "alpine-latest:docker://alpine:latest"
            "alpine-edge:docker://alpine:edge"
            "alpine-3.23:docker://alpine:3.23"

            "archlinux:docker://archlinux:base-devel"

            "nixos-unstable:docker://docker.nix-community.org/nixpkgs/nix-flakes:latest-x86_64-linux"
            "nixos-25.11:docker://docker.nix-community.org/nixpkgs/nix-flakes:nixos-25.11-x86_64-linux"

            "native:host"
          ],
          sopsFile,
          enable ? true,
        }:
        let
          secret = "forgejo_runner_env-${name}";
        in
        {
          description = "Add a new forgejo runner instance with a secret";
          includes = [ den.aspects.apps._.sops ];
          nixos =
            { config, ... }:
            {
              services.gitea-actions-runner = {
                instances.${name} = {
                  inherit
                    name
                    url
                    labels
                    enable
                    ;
                  tokenFile = config.sops.secrets.${secret}.path;
                };
              };
              sops.secrets.${secret} = {
                sopsFile = sopsFile;
                format = "dotenv";
                key = "";
              };
            };
        };
    };
  };
}
