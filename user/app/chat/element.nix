{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ ../utils/electron.nix ];

  home.packages = [ pkgs.element-desktop ];
}
