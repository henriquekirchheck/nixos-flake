{ inputs, den, ... }:
{
  flake-file.inputs.niri = {
    url = "github:sodiboo/niri-flake";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.window-managers.provides.niri = {
    includes = [
      (den.aspects.utils._.nixpkgs._.add-substituter {
        substituter = "https://niri.cachix.org";
        public-key = "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964=";
      })
      (den.aspects.utils._.nixpkgs._.add-overlay inputs.niri.overlays.niri)
    ];
    description = "Niri";
    nixos =
      { pkgs, ... }:
      {
        imports = [ inputs.niri.nixosModules.niri ];
        niri-flake.cache.enable = false;

        programs.niri = {
          enable = true;
          package = pkgs.niri-unstable;
        };
        xdg.portal = {
          enable = true;
          extraPortals = [
            pkgs.xdg-desktop-portal-gtk
            pkgs.xdg-desktop-portal-gnome
          ];
          config.niri = {
            default = [
              "gnome"
              "gtk"
            ];
            "org.freedesktop.impl.portal.ScreenCast" = "gnome";
            "org.freedesktop.impl.portal.FileChooser" = "gtk";
            "org.freedesktop.impl.portal.Access" = "gtk";
            "org.freedesktop.impl.portal.Notification" = "gtk";
            "org.freedesktop.impl.portal.AppChooser" = "gtk";
            "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
          };
        };

        # Fix services starting before niri-session
        systemd.user.services = {
          xdg-desktop-portal = {
            after = [ "xdg-desktop-autostart.target" ];
          };
          xdg-desktop-portal-gtk = {
            after = [ "xdg-desktop-autostart.target" ];
          };
          xdg-desktop-portal-gnome = {
            after = [ "xdg-desktop-autostart.target" ];
          };
          niri-flake-polkit = {
            after = [ "xdg-desktop-autostart.target" ];
          };
        };
      };
    homeManager =
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {
        imports = [ inputs.niri.homeModules.config ];
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
                opacity = 0.98;
                draw-border-with-background = false;
              }
              {
                matches = [
                  { is-active = false; }
                ];
                opacity = 0.92;
              }
              {
                matches = [
                  { app-id = "^org\.wezfurlong\.wezterm$"; }
                  { app-id = "Alacritty"; }
                  { app-id = "zen"; }
                  { app-id = "com.mitchellh.ghostty"; }
                  { app-id = "kitty"; }
                  { app-id = "swayimg"; }
                ];
                draw-border-with-background = false;
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
                    title = "Extension:.*Bitwarden.*";
                    app-id = "firefox";
                  }
                ];
                open-floating = true;
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
                matches = [
                  {
                    app-id = "org.quickshell$";
                  }
                ];
                open-floating = true;
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
                  bottom-left = 12.0;
                  bottom-right = 12.0;
                  top-right = 12.0;
                  top-left = 12.0;
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
                # Apps
                "Mod+Return".action = spawn-sh "alacritty msg create-window || alacritty";
                "Mod+B".action = spawn "firefox";
                "Mod+P".action = lib.mkForce (spawn "rofi" "-show" "run");
                "Mod+Space".action = lib.mkDefault (spawn "rofi" "-show" "drun");

                # Screenshot
                "Print".action.screenshot = { };
                "Shift+Print".action.screenshot-screen = {
                  write-to-disk = false;
                };
                "Ctrl+Print".action.screenshot-window = {
                  write-to-disk = false;
                };

                # Screencast
                "Mod+Shift+R".action.set-dynamic-cast-monitor = { };
                "Mod+Ctrl+R".action.set-dynamic-cast-window = { };
                "Mod+R".action.clear-dynamic-cast-target = { };

                # WM keybinds
                "Mod+Shift+C".action = close-window;
                "Mod+Shift+Q".action = quit { skip-confirmation = true; };
                "Mod+F".action = toggle-window-floating;
                "Mod+Shift+F".action = fullscreen-window;
                "Mod+S".action = switch-preset-column-width;
                "Mod+A".action = toggle-overview;

                # Move Windows
                "Mod+Up".action = focus-window-or-workspace-up;
                "Mod+Down".action = focus-window-or-workspace-down;
                "Mod+Left".action = focus-column-left;
                "Mod+Right".action = focus-column-right;
                "Mod+Shift+Up".action = move-window-up-or-to-workspace-up;
                "Mod+Shift+Down".action = move-window-down-or-to-workspace-down;
                "Mod+Shift+Left".action = move-column-left;
                "Mod+Shift+Right".action = move-column-right;

                # Volume control
                "XF86AudioRaiseVolume".action = lib.mkDefault (
                  spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"
                );
                "XF86AudioLowerVolume".action = lib.mkDefault (
                  spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"
                );
                "XF86AudioMute".action = lib.mkDefault (spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle");
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
      };
  };
}
