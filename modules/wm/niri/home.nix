{
  config,
  pkgs,
  lib,
  ...
}:

{
  # imports = [inputs.niri.homeModules.config];
  home.packages = with pkgs; [
    xwayland-run
    openbox
  ];

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  programs.niri = {
    package = pkgs.niri-unstable;
    settings = {
      prefer-no-csd = true;
      environment = { };
      hotkey-overlay.skip-at-startup = true;

      screenshot-path = "${config.xdg.userDirs.pictures}/screenshots";

      xwayland-satellite = {
        enable = true;
        path = lib.getExe pkgs.xwayland-satellite-unstable;
      };

      overview = {
        backdrop-color = "#11111b";
        workspace-shadow.enable = false;
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
          matches = [
            { app-id = "xwaylandvideobridge"; }
          ];
          opacity = 0.0;
          open-focused = false;
          max-width = 1;
          max-height = 1;
          shadow.enable = false;
          border.enable = false;
          focus-ring.enable = false;
        }
        {
          matches = [
            {
              app-id = "steam";
              title = ''^notificationtoasts_\d+_desktop$'';
            }
          ];
          default-floating-position = {
            x = 10;
            y = 10;
            relative-to = "bottom-right";
          };
	  open-focused = false;
        }
        {
          matches = [ { is-window-cast-target = true; } ];
          border = {
            inactive.color = "#eba0ac";
            active.gradient = {
              from = "#f38ba8";
              to = "#fab387";
              angle = 45;
              relative-to = "workspace-view";
            };
          };
        }
        {
          geometry-corner-radius = {
            bottom-left = 8.0;
            bottom-right = 8.0;
            top-right = 8.0;
            top-left = 8.0;
          };
          clip-to-geometry = true;
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
          natural-scroll = false;
        };
        power-key-handling.enable = false;
        focus-follows-mouse.enable = true;
      };

      layout = {
        gaps = 4;
        # center-focused-column = "on-overflow";
        always-center-single-column = true;
	preset-column-widths = [
          { proportion = 1. / 4.; }
          { proportion = 1. / 3.; }
          { proportion = 1. / 2.; }
          { proportion = 2. / 3.; }
          { proportion = 1. / 1.; }
	];
        focus-ring.enable = false;
        border = {
          enable = true;
          width = 2;
          inactive.color = "#181825";
          active.gradient = {
            from = "#cba6f7";
            to = "#74c7ec";
            angle = 45;
            relative-to = "workspace-view";
          };
        };
        struts = {
          left = 4;
          right = 4;
          top = 4;
          bottom = 4;
        };
      };

      debug.honor-xdg-activation-with-invalid-serial = true;

      binds =
        with config.lib.niri.actions;
        {
          "Mod+Return".action = spawn "kitty";
          "Mod+B".action = spawn "firefox";
          "Mod+V".action = spawn "codium";
          "Mod+P".action = spawn "rofi" "-show" "run";
          "Mod+Space".action = spawn "rofi" "-show" "drun";
          "Print".action.screenshot = { };
          "Shift+Print".action.screenshot-screen = {
            write-to-disk = false;
          };
          "Ctrl+Print".action.screenshot-window = {
            write-to-disk = false;
          };
          "Mod+Shift+C".action = close-window;
          "Mod+Shift+Q".action = quit { skip-confirmation = true; };
          "Mod+F".action = toggle-window-floating;
          "Mod+Shift+F".action = fullscreen-window;
          "Mod+S".action = switch-preset-column-width;
          "Mod+A".action = toggle-overview;

          "Mod+Up".action = focus-window-or-workspace-up;
          "Mod+Down".action = focus-window-or-workspace-down;
          "Mod+Left".action = focus-column-left;
          "Mod+Right".action = focus-column-right;
          "Mod+Shift+Up".action = move-window-up-or-to-workspace-up;
          "Mod+Shift+Down".action = move-window-down-or-to-workspace-down;
          "Mod+Shift+Left".action = move-column-left;
          "Mod+Shift+Right".action = move-column-right;

          "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
          "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
          "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
        }
        // lib.mergeAttrsList (
          builtins.genList (
            x:
            let
              n = x + 1;
            in
            {
              "Mod+${toString n}".action = focus-workspace n;
            }
          ) 9
        );
    };
  };
}
