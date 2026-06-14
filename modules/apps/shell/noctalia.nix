{ inputs, ... }:
{
  flake-file.inputs.noctalia = {
    url = "github:noctalia-dev/noctalia-shell";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.apps.provides.shell.provides.noctalia = {
    homeManager =
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {
        imports = [ inputs.noctalia.homeModules.default ];
        programs.noctalia = {
          enable = true;
          systemd.enable = true;

          settings = {
            shell = {
              telemetry_enabled = false;
              niri_overview_type_to_launch_enabled = false;
              polkit_agent = true;
              settings_show_advanced = true;
              launch_apps_as_systemd_services = true;

              time_format = "{:%I:%M %p}";
              date_format = "{:%A}\n{:%Y-%m-%d}";

              font_family = "JetBrainsMono Nerd Font Propo";
              lang = "en";

              clipboard_enabled = true;
              clipboard_history_max_entries = 50;
              clipboard_auto_paste = "auto";

              animation = {
                enabled = true;
                speed = 1.0;
              };

              panel = {
                background_blur = true;
                transparency_mode = "glass";
                borders = true;
                shadow = true;
                launcher_placement = "attached";
                clipboard_placement = "attached";
                control_center_placement = "attached";
                wallpaper_placement = "attached";
                session_placement = "attached";

                open_near_click_launcher = true;
                open_near_click_control_center = true;
                open_near_click_clipboard = true;
                open_near_click_wallpaper = true;
                open_near_click_session = true;
              };

              screen_corners = {
                enabled = true;
                size = 24;
              };
            };

            bar.default = {
              position = "bottom";
              capsule = true;
              capsule_opacity = 0.6;
              capsule_padding = 11.0;
              margin_edge = 4.0;
              margin_ends = 4.0;
              background_opacity = 0.4;
              start = [
                "launcher"
                "tray"
                "workspaces"
              ];
              center = [
                "audio_visualizer"
                "media"
              ];
              end = [
                "clipboard"
                "notifications"
                "notclip"
                "cpu"
                "ram"
                "system"
                "volume"
                "brightness"
                "control-center"
                "clock"
              ];
            };

            theme = {
              mode = "dark";
              source = "builtin";
              builtin = "Catppuccin";
            };
            wallpaper = {
              enabled = true;
              directory = "${config.xdg.userDirs.pictures}/Wallpapers";
              automation = {
                enabled = true;
                interval_minutes = 10;
                order = "random";
                recursive = true;
              };
            };
            backdrop = {
              enabled = true;
              blur_intensity = 0.5;
              tint_intensity = 0.1;
            };
            dock.enabled = false;

            system.monitor = {
              enabled = true;
              cpu_poll_seconds = 2.0;
              gpu_poll_seconds = 5.0;
              memory_poll_seconds = 2.0;
              network_poll_seconds = 3.0;
              disk_poll_seconds = 10.0;
            };

            notification = {
              enable_daemon = true;
              power_profile_notify = true;
              position = "bottom_right";
              layer = "top";
              background_opacity = 0.40;
              offset_x = 8;
              offset_y = 8;
              scale = 0.8;
              monitors = [ ];
              collapse_on_dismiss = true;
            };

            osd.position = "bottom_center";

            control_center.shortcuts = [
              { type = "caffeine"; }
              { type = "nightlight"; }
              { type = "notification"; }
              { type = "wallpaper"; }
              { type = "audio"; }
              { type = "mic_mute"; }
            ];

            widget = {
              launcher = {
                custom_image = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake-white.svg";
              };
              system = {
                length = 10.0;
                type = "spacer";
              };
              audio_visualizer = {
                bands = 24;
                high_color = "error";
                low_color = "secondary";
                show_when_idle = true;
                width = 100.0;
              };
              battery = {
                hide_when_full = true;
              };
              control-center = {
                glyph = "adjustments-alt";
              };
              notclip = {
                length = 10.0;
                type = "spacer";
              };
              ram = {
                display = "text";
              };
              workspaces = {
                hide_when_empty = true;
                minimal = true;
              };
            };

            desktop_widgets = rec {
              schema_version = 1;
              widget_order = builtins.attrNames widget;

              grid = {
                cell_size = 24;
                major_interval = 4;
                visible = true;
              };

              widget = {
                clock = {
                  cx = 1752.0;
                  cy = 84.0;
                  output = "HDMI-A-1";
                  rotation = 0.0;
                  scale = 1.6;
                  type = "clock";

                  settings = {
                    background = false;
                    color = "primary";
                    shadow = false;
                  };
                };

                audio_visualizer = {
                  cx = 960.0;
                  cy = 882.0;
                  output = "HDMI-A-1";
                  rotation = 0.0;
                  scale = 5.25;
                  type = "audio_visualizer";

                  settings = {
                    aspect_ratio = 6.0;
                    background = false;
                    bands = 44;
                    centered = false;
                    high_color = "tertiary";
                    low_color = "error";
                    mirrored = true;
                    show_when_idle = true;
                  };
                };
              };
            };
          };
        };
      };
    provides.niri.homeManager =
      { config, lib, ... }:
      {
        programs.niri = {
          settings = {
            layer-rules = [
              {
                matches = [ { namespace = "^noctalia-backdrop"; } ];
                place-within-backdrop = true;
              }
            ];
            window-rules = [
              {
                matches = [ { app-id = "dev.noctalia.Noctalia.Settings"; } ];
                open-floating = true;
              }
            ];
            binds =
              let
                noctalia-ipc = args: {
                  spawn = [
                    "noctalia"
                    "msg"
                  ]
                  ++ args;
                };
              in
              {
                "Mod+Space" = {
                  action = noctalia-ipc [
                    "panel-toggle"
                    "launcher"
                  ];
                  hotkey-overlay.title = "Toggle Application Launcher";
                };
                "Mod+Comma" = {
                  action = noctalia-ipc [ "settings-toggle" ];
                  hotkey-overlay.title = "Toggle Settings";
                };
                "Mod+X" = {
                  action = noctalia-ipc [
                    "panel-toggle"
                    "session"
                  ];
                  hotkey-overlay.title = "Toggle Power Menu";
                };
                "Mod+V" = {
                  action = noctalia-ipc [
                    "panel-toggle"
                    "clipboard"
                  ];
                  hotkey-overlay.title = "Toggle Clipboard Manager";
                };
                "Super+Alt+L" = {
                  action = noctalia-ipc [ "screen-lock" ];
                  hotkey-overlay.title = "Toggle Lock Screen";
                };

                "XF86AudioRaiseVolume" = {
                  allow-when-locked = true;
                  action = noctalia-ipc [ "volume-up" ];
                };
                "XF86AudioLowerVolume" = {
                  allow-when-locked = true;
                  action = noctalia-ipc [ "volume-down" ];
                };
                "XF86AudioMute" = {
                  allow-when-locked = true;
                  action = noctalia-ipc [ "volume-mute" ];
                };
                "XF86AudioMicMute" = {
                  allow-when-locked = true;
                  action = noctalia-ipc [ "mic-mute" ];
                };
                "XF86MonBrightnessUp" = {
                  allow-when-locked = true;
                  action = noctalia-ipc [ "brightness-up" ];
                };
                "XF86MonBrightnessDown" = {
                  allow-when-locked = true;
                  action = noctalia-ipc [ "brightness-down" ];
                };
              };
          };
        };
      };
  };
}
