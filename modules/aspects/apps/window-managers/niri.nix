{
  __findFile,
  config,
  lib,
  inputs,
  ...
}:
{
  flake-file.inputs = {
    niri = {
      # url = "github:sodiboo/niri-flake";
      url = "github:epireyn/niri-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-stable.follows = "";
        niri-unstable.follows = "niri-src";
        niri-stable.follows = "";
        xwayland-satellite-unstable.follows = "xwayland-satellite-src";
        xwayland-satellite-stable.follows = "";
      };
    };
    xwayland-satellite-src = {
      url = "github:supreeeme/xwayland-satellite";
      flake = false;
    };
    niri-src = {
      url = "github:niri-wm/niri";
      flake = false;
    };
  };

  den.quirks = {
    niri-window-rules.description = "Window Rules for Niri";
    niri-layer-rules.description = "Layer Rules for Niri";
    niri-binds.description = "Binds for Niri";
  };

  den.aspects.apps.window-managers.niri = {
    includes = [
      <apps/display/wayland>
      <apps/window-managers/niri/collect>
    ];

    niri-window-rules = _: [
      {
        geometry-corner-radius = {
          bottom-left = 12.0;
          bottom-right = 12.0;
          top-right = 12.0;
          top-left = 12.0;
        };
        clip-to-geometry = true;
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
        matches = [ { is-active = false; } ];
        opacity = 0.975;
      }
    ];

    niri-binds = _: [
      (lib.mkMerge [
        {
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
          "Mod+Shift+C".action.close-window = { };
          "Mod+Shift+Q".action.quit = {
            skip-confirmation = true;
          };
          "Mod+F".action.toggle-window-floating = { };
          "Mod+Shift+F".action.fullscreen-window = { };
          "Mod+S".action.switch-preset-column-width = { };
          "Mod+A".action.toggle-overview = { };

          # Move Windows
          "Mod+Up".action.focus-window-or-workspace-up = { };
          "Mod+Down".action.focus-window-or-workspace-down = { };
          "Mod+Left".action.focus-column-left = { };
          "Mod+Right".action.focus-column-right = { };
          "Mod+Shift+Up".action.move-window-up-or-to-workspace-up = { };
          "Mod+Shift+Down".action.move-window-down-or-to-workspace-down = { };
          "Mod+Shift+Left".action.move-column-left = { };
          "Mod+Shift+Right".action.move-column-right = { };
        }
        (lib.mergeAttrsList (
          builtins.genList (
            x:
            let
              n = x + 1;
            in
            {
              "Mod+${toString n}".action.focus-workspace = n;
            }
          ) 9
        ))
      ])
    ];

    nixos = { pkgs, ... }: {
      imports = [ inputs.niri.nixosModules.niri ];

      niri-flake.cache.enable = false;
      systemd.user.services.niri-flake-polkit.enable = false;
      services.gnome.gnome-keyring.enable = lib.mkForce false;

      programs.niri = {
        enable = true;
        package = pkgs.niri-unstable;
      };
    };

    homeManager =
      {
        host,
        config,
        lib,
        pkgs,
        ...
      }:
      {
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
          };
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

            inherit (host.settings.batteries.peripheral) outputs;

            input = {
              keyboard = {
                numlock = true;
                inherit (host.settings.batteries.peripheral) xkb;
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
              struts = {
                left = 4;
                right = 4;
                top = 4;
                bottom = 4;
              };
            };

            debug.honor-xdg-activation-with-invalid-serial = true;
          };
        };
      };

    nixpkgs-substituters = _: [
      (lib.mkIf (config.flake-file.inputs.niri.url == "github:sodiboo/niri-flake") {
        substituter = "https://niri.cachix.org";
        public-key = "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964=";
      })
      (lib.mkIf (config.flake-file.inputs.niri.url == "github:epireyn/niri-flake") {
        substituter = "https://niri-epireyn.cachix.org";
        public-key = "niri-epireyn.cachix.org-1:tlVyFN7CtsDT+ZcLPS+ekFWeT1X6X4OqvWqbBMyIzFA=";
      })
    ];
    nixpkgs-overlays = _: [ inputs.niri.overlays.niri ];
  };

  den.aspects.apps.window-managers.niri.collect = {
    homeManager =
      {
        niri-window-rules,
        niri-layer-rules,
        niri-binds,
      }:
      {
        programs.niri.settings = {
          window-rules = lib.unique (lib.flatten niri-window-rules);
          layer-rules = lib.unique (lib.flatten niri-layer-rules);
          binds = lib.mkMerge niri-binds;
        };
      };
  };
}
