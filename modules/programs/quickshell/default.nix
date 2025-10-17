{
  inputs,
  system,
  ...
}:

{
  programs.quickshell = {
    enable = true;
    package = inputs.quickshell.packages.${system}.default;
    configs.shell = ./config;
    activeConfig = "shell";
    systemd.enable = true;
  };
}
