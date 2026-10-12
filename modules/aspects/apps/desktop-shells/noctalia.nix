{ __findFile, den, ... }:
{
  den.aspects.apps.desktop-shells.noctalia = {
    includes = [
      (den.lib.policy.when (
        { host, ... }: host.hasAspect <stylix.module>
      ) <apps/desktop-shells/noctalia/stylix/disable>)
    ];
    homeManager =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        home.packages = [ pkgs.awww ];
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

              font_family = lib.mkForce "JetBrainsMono Nerd Font Propo";
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
              background_opacity = lib.mkForce 0.4;
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
                "recorder"
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
              templates = {
                enable_builtin_templates = false;
                enable_community_templates = false;
              };
            };
            wallpaper = {
              enabled = true;
              directory = "${config.xdg.userDirs.pictures}/wallpapers";
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
              background_opacity = lib.mkForce 0.4;
              offset_x = 8;
              offset_y = 8;
              scale = 0.8;
              monitors = [ ];
              collapse_on_dismiss = true;
            };

            osd = {
              position = "bottom_center";
              background_opacity = lib.mkForce 0.4;
            };

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
              recorder.type = "noctalia/screen_recorder:recorder";
            };

            plugins.enabled = [
              "noctalia/screen_recorder"
              "noctalia/kaomoji"
              "0lucasmatheus/awwwall"
              "kenn/keybind-cheatsheet"
              "whyoolw/sharednd"
            ];
            plugin_settings = {
              "noctalia/screen_recorder".directory = config.xdg.userDirs.videos;
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
                audio_visualizer = {
                  cx = 960.0;
                  cy = 888.0;
                  output = "HDMI-A-1";
                  box_height = 312.0;
                  box_width = 1920.0;
                  placement_height = 1080.0;
                  placement_width = 1920.0;
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

            lockscreen_widgets.enabled = false;
          };
        };
      };

    niri-window-rules = _: [
      {
        matches = [ { app-id = "dev.noctalia.Noctalia.Settings"; } ];
        open-floating = true;
      }
    ];
    niri-layer-rules = _: [
      {
        matches = [ { namespace = "^noctalia-backdrop"; } ];
        place-within-backdrop = true;
      }
      {
        matches = [ { namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$"; } ];
        background-effect.xray = false;
      }
    ];
    niri-binds = _: [
      (
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
          "Mod+Period" = {
            action = noctalia-ipc [
              "panel-toggle"
              "kenn/keybind-cheatsheet:cheatsheet"
            ];
            hotkey-overlay.title = "Toggle Keybind Cheatsheet";
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
        }
      )
    ];
    cacheHome = _: {
      directories = [ ".local/state/noctalia" ];
    };
  };
  den.aspects.apps.desktop-shells.noctalia.stylix.disable = {
    homeManager.stylix.targets.noctalia.enable = false;
  };
}
