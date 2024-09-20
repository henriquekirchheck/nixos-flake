{ pkgs, config, dotfilesDir, ... }:

let dotfilesFullDir = "${config.home.homeDirectory}/${dotfilesDir}"; in
{
  home.packages = [
    (pkgs.writeScriptBin "nixos-update" ''
      #!/bin/sh
      pushd ${dotfilesFullDir}
        nix flake update
        git add flake.lock
        git commit -m "$(date) - Flake Update"
      popd

      nixos-rebuild switch --flake ${dotfilesFullDir} --use-remote-sudo --log-format internal-json -v |& nom --json
      home-manager switch --flake ${dotfilesFullDir} -v |& nom
    '')
  ];
}
