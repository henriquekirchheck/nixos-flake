{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bun
    deno
    nodejs_latest
    nodePackages.pnpm
  ];
}
