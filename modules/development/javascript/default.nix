{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bun
    deno
    nodejs
    nodePackages.pnpm
  ];
}
