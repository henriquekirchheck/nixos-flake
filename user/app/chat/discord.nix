{ config, lib, pkgs, ... }:

{
  imports = [ ../utils/electron.nix ];

  home.packages = [
    (pkgs.discord-canary.override {
      # withOpenASAR = true;
      withVencord = true;
    })
  ];
}
