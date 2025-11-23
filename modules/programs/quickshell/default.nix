{
  inputs,
  pkgs,
  ...
}:

{
  programs.quickshell = {
    enable = true;
    package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
    configs.shell = ./config;
    activeConfig = "shell";
    systemd.enable = true;
  };
}
