{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ rust-bin.stable.latest.default pkg-config ];
}
