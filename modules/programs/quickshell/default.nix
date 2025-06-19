{ pkgs, inputs, ... }:
{
  imports = [
    ../../../packages/hmModules/quickshell.nix
  ];

  programs.quickshell = {
    enable = true;
    package = inputs.quickshell.packages.${pkgs.system}.default;
    extraPackages = [
      (import ../../../packages).beat-detector
      pkgs.fish
      pkgs.cava
    ];
    config = ./config;
  };
}
