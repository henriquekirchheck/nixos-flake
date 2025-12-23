{
  config,
  pkgs,
  ...
}:

{
  services.gitea-actions-runner = {
    package = pkgs.forgejo-runner;
    instances.default = {
      enable = true;
      name = config.networking.hostName;
      url = "https://codeberg.org";
      labels = [
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
      ];
    };
  };
}
