{ pkgs, inputs, ... }:
{
  imports = [
    pkgs.nur.repos.henriquekh.hmModules.quickshell
  ];

  programs.quickshell = {
    enable = true;
    package = inputs.quickshell.packages.${pkgs.system}.default;
    extraPackages = [ ];
    config = ./config;
  };
}
