{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
      gcc
      gnumake
      cmake
      stdenv
      autoconf
      automake
      libtool
      # clang
      clang-tools
  ];
}
