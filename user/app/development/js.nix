{ config, pkgs, lib, ... }:
let
  fnmConfig = ''eval "$(fnm env --use-on-cd)"'';
in {
  home.packages = with pkgs; [
    fnm
    bun
    nodejs_20
    nodePackages.pnpm
  ];
  programs.zsh.initExtra = fnmConfig;
  programs.bash.initExtra = fnmConfig;
}