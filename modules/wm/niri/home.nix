{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:

{
  import = [ inputs.niri.homeModules.niri ];
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
    settings = {
      prefer-no-csd = true;
      environment = { };
      hotkey-overlay.skip-at-startup = true;
      xwayland-satelite = {
        enable = true;
        path = lib.getExe pkgs.xwayland-satellite-unstable;
      };

      window-rules = [
        {
          matches = [
            { app-id = "Code"; }
            { app-id = "VSCodium"; }
            { app-id = "codium-url-handler"; }
            { app-id = "code-url-handler"; }
            { app-id = "discord"; }
            { app-id = "vesktop"; }
          ];
          opacity = 0.92;
        }
        {
          matches = [ { is-window-cast-target = true; } ];
          border = {
            inactive-color = "#eba0ac";
            active-gradient = {
              from = "#f38ba8";
              to = "#fab387";
              angle = 45;
              relative-to = "workspace-view";
            };
          };
        }
      ];

      input = {
        keyboard = {
          numlock = true;
          xkb = {
            layout = "br";
            model = "abnt2";
            options = "caps:escape_shifted_capslock";
          };
        };
        mouse.accel-profile = "flat";
        touchpad = {
          accel-profile = "flat";
          click-method = "clickfinger";
          drag = true;
          tap-button-map = "left-right-middle";
        };
        power-key-handling.enable = false;
        focus-follows-mouse.enable = true;
      };

      layout = {
        gaps = 4;
        center-focused-column = "on-overflow";
        always-center-single-column = true;
        border = {
          width = 2;
          inactive_color = "#181825";
          active-gradient = {
            from = "#cba6f7";
            to = "#74c7ec";
            angle = 45;
            relative-to = "workspace-view";
          };
        };
      };

      binds = with config.lib.niri.actions; {
        "Mod+Return".action = spawn "kitty";
        "Mod+B".action = spawn "firefox";
        "Mod+V".action = spawn "codium";
        "Mod+P".action = spawn "rofi" "-show" "run";
        "Mod+Space".action = spawn "rofi" "-show" "drun";
        "Print".action = screenshot { };
        "Shift+Print".action = screenshot-screen { write-to-disk = false; };
        "Ctrl+Print".action = screenshot-window { write-to-disk = false; };
        "Mod+Shift+C".action = close-window;
        "Mod+Shift+Q".action = exit;
        "Mod+F".action = toggle-window-floating;
        "Mod+Shift+F".action = fullscreen-window;
        "Mod+R".action = load-config-file;
        "Mod+A".action = toggle-overview;

        "Mod+Up".action = focus-window-or-workspace-up;
        "Mod+Down".action = focus-window-or-workspace-down;
        "Mod+Left".action = focus-column-left;
        "Mod+Right".action = focus-column-right;
        "Mod+Shift+Up".action = move-window-or-workspace-up;
        "Mod+Shift+Down".action = move-window-or-workspace-down;
        "Mod+Shift+Left".action = move-column-left;
        "Mod+Shift+Right".action = move-column-right;

        "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
        "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
        "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
      };
    };
  };
}
