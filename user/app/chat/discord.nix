{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ ../utils/electron.nix ];

  home.packages = [
    pkgs.vesktop
    (pkgs.discord-canary.override {
      withOpenASAR = true;
      withVencord = true;
    })
  ];
}
