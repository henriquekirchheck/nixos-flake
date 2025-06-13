{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rustc
    cargo
    gcc
    rustfmt
    rust-analyzer
    clippy
  ];
  home.sessionVariables = {
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  };
}
