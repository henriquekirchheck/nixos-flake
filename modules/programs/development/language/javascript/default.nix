{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bun
    deno
    nodejs
    nodePackages.pnpm
    typescript-language-server
    angular-language-server
    svelte-language-server
  ];
}
