{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    nixd
    nixfmt-rfc-style
  ];
}
