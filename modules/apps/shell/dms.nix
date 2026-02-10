{ inputs, ... }:
{
  flake-file.inputs.dms = {
    url = "github:AvengeMedia/DankMaterialShell";
    inputs = {
      nixpkgs.follows = "nixpkgs";
      quickshell.follows = "quickshell";
    };
  };

  den.aspects.apps.provides.shell.provides.dms = {
    homeManager =
      { pkgs, ... }:
      {
        imports = [ inputs.dms.homeModules.dank-material-shell ];

        programs.dank-material-shell = {
          enable = true;
          quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;

          systemd = {
            enable = true; # Systemd service for auto-start
            restartIfChanged = true; # Auto-restart dms.service when dankMaterialShell changes
          };

          enableSystemMonitoring = true;
          enableVPN = false;
          enableDynamicTheming = false;
          enableAudioWavelength = true;
          enableCalendarEvents = false;
        };
      };
    provides.niri.homeManager =
      { config, lib, ... }:
      {
        programs.niri.settings.binds =
          let
            dms-ipc = args: {
              spawn = [
                "dms"
                "ipc"
              ]
              ++ args;
            };
          in
          {
            "Mod+Space" = {
              action = dms-ipc [
                "spotlight"
                "toggle"
              ];
              hotkey-overlay.title = "Toggle Application Launcher";
            };
            "Mod+N" = {
              action = dms-ipc [
                "notifications"
                "toggle"
              ];
              hotkey-overlay.title = "Toggle Notification Center";
            };
            "Mod+Comma" = {
              action = dms-ipc [
                "settings"
                "toggle"
              ];
              hotkey-overlay.title = "Toggle Settings";
            };
            "Mod+P" = {
              action = dms-ipc [
                "notepad"
                "toggle"
              ];
              hotkey-overlay.title = "Toggle Notepad";
            };
            "Super+Alt+L" = {
              action = dms-ipc [
                "lock"
                "lock"
              ];
              hotkey-overlay.title = "Toggle Lock Screen";
            };
            "Mod+X" = {
              action = dms-ipc [
                "powermenu"
                "toggle"
              ];
              hotkey-overlay.title = "Toggle Power Menu";
            };
            "XF86AudioRaiseVolume" = {
              allow-when-locked = true;
              action = dms-ipc [
                "audio"
                "increment"
                "3"
              ];
            };
            "XF86AudioLowerVolume" = {
              allow-when-locked = true;
              action = dms-ipc [
                "audio"
                "decrement"
                "3"
              ];
            };
            "XF86AudioMute" = {
              allow-when-locked = true;
              action = dms-ipc [
                "audio"
                "mute"
              ];
            };
            "XF86AudioMicMute" = {
              allow-when-locked = true;
              action = dms-ipc [
                "audio"
                "micmute"
              ];
            };
            "XF86MonBrightnessUp" = {
              allow-when-locked = true;
              action = dms-ipc [
                "brightness"
                "increment"
                "5"
              ];
            };
            "XF86MonBrightnessDown" = {
              allow-when-locked = true;
              action = dms-ipc [
                "brightness"
                "decrement"
                "5"
              ];
            };
            "Mod+Alt+N" = {
              allow-when-locked = true;
              action = dms-ipc [
                "night"
                "toggle"
              ];
              hotkey-overlay.title = "Toggle Night Mode";
            };
            "Mod+V" = {
              action = dms-ipc [
                "clipboard"
                "toggle"
              ];
              hotkey-overlay.title = "Toggle Clipboard Manager";
            };
          }
          // lib.attrsets.optionalAttrs config.programs.dank-material-shell.enableSystemMonitoring {
            "Mod+M" = {
              action = dms-ipc [
                "processlist"
                "toggle"
              ];
              hotkey-overlay.title = "Toggle Process List";
            };
          };
      };
  };
}
