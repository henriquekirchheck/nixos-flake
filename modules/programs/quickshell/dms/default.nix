{
  inputs,
  pkgs,
  osConfig,
  ...
}:

{
  imports = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
  ];

  programs.dankMaterialShell = {
    enable = true;
    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;

    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dankMaterialShell changes
    };

    niri.enableKeybinds = true;

    enableSystemMonitoring = true;
    enableClipboard = true;
    enableVPN = false;
    enableBrightnessControl = osConfig.networking.hostName == "henrique-laptop";
    enableColorPicker = true;
    enableDynamicTheming = false;
    enableAudioWavelength = true;
    enableCalendarEvents = false;
    enableSystemSound = false;
  };
}
