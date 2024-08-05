{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ (rust-bin.stable.latest.default.override {
    extensions = [ "rust-src" ];
  }) pkg-config ];
}
