{ config, pkgs, terminal, browser, mainEditor, inputs, ... }:

let
  winWrapClass = "terminal-background";
  winWrapBinName = "cava-wrap";
  winWrapBin = ''
    #!/bin/sh
    sleep 0.5 && cava
  '';
  winWrapConfigFile = "hypr/kitty-${winWrapClass}.conf";
  winWrapConfig = ''
    background_opacity 0.0
  '';
in {
  imports = [
    ../app/browser/${browser}.nix
    ../app/terminal/${terminal}.nix
    ../app/editor/${mainEditor}.nix
    ../app/utils/rofi/rofi.nix
    ../app/utils/dunst.nix
    ../app/utils/waybar.nix
  ];

  home.packages = with pkgs; [
    grimblast
    swww
    wl-clipboard
    (pkgs.writeScriptBin winWrapBinName winWrapBin)
    kitty
    kdePackages.polkit-kde-agent-1
  ];
  xdg.configFile.${winWrapConfigFile}.text = winWrapConfig;

  programs.cava = {
    enable = true;
    settings = {
      general = {
        mode = "normal";
        framerate = 60;
      };
      input = {
        method = "pipewire";
        source = "auto";
      };
      output.method = "noncurses";
      color = {
        gradient = 1;
        gradient_count = 8;
        gradient_color_1 = "'#bf616a'";
        gradient_color_2 = "'#d08770'";
        gradient_color_3 = "'#ebcb8b'";
        gradient_color_4 = "'#a3be8c'";
        gradient_color_5 = "'#b48ead'";
        gradient_color_6 = "'#88c0d0'";
        gradient_color_7 = "'#81a1c1'";
        gradient_color_8 = "'#5e81ac'";
      };
      smoothing.noise_reduction = 88;
    };
  };

  home.file = {
    "phinger-cursors-light" = {
      source = "${inputs.hyprcursor-phinger.packages.${pkgs.system}.hyprcursor-phinger}/cursors/theme_phinger-cursors-light";
      target = ".local/share/icons/phinger-hyprcursors-light";
    };
    "phinger-cursors-dark" = {
      source = "${inputs.hyprcursor-phinger.packages.${pkgs.system}.hyprcursor-phinger}/cursors/theme_phinger-cursors-dark";
      target = ".local/share/icons/phinger-hyprcursors-dark";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.variables = ["--all"];
    plugins = [ inputs.hyprland-plugins.packages.${pkgs.system}.hyprwinwrap ];
    settings = {
      env = [
        # Nvidia fixes
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "WLR_NO_HARDWARE_CURSORS,1"

        # XDG Specifications
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"

        # Use Wayland by default if possible
        "GDK_BACKEND,wayland,x11,*"
        "QT_QPA_PLATFORM,wayland;xcb"
        "MOZ_ENABLE_WAYLAND,1"
        "MOZ_DRM_DEVICE,/dev/dri/renderD128"
        "SDL_VIDEODRIVER,wayland"
        "CLUTTER_BACKEND,wayland"

        # Qt specific configs
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_QPA_PLATFORMTHEME,qt6ct"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"

        # Hyprcursor config
        "HYPRCURSOR_THEME,${config.home.pointerCursor.name}"
        "HYPRCURSOR_SIZE,${toString config.home.pointerCursor.size}"
      ];
      exec-once = [
        "swww init"
        "waybar"
        "dbus-launch --exit-with-session"
        "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1"
        "dunst"
        "vesktop --start-minimized"
        "kitty -c \"$XDG_CONFIG_HOME/${winWrapConfigFile}\" --class=\"${winWrapClass}\" ${winWrapBinName}"
      ];
      input = {
        kb_layout = "br";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        touchpad = {
          natural_scroll = false;
        };
        numlock_by_default = true;
        sensitivity = 0;
        follow_mouse = 1;
        float_switch_override_focus = 0;
      };
      general = {
        gaps_in = 4;
        gaps_out = 4;
        border_size = 2;
        col = {
          active_border = "rgb(b48ead)";
          inactive_border = "rgb(4c566a)";
        };
        layout = "dwindle";
      };
      decoration = {
        rounding = 5;
        blur = {
          enabled = true;
          size = 3;
          passes = 2;
          new_optimizations = true;
        };
        drop_shadow = true;
        shadow_range = 2;
        shadow_render_power = 3;
        col.shadow = "rgba(1a1a1aee)";
      };
      animations = {
        enabled = true;
        bezier = [
          "simple, 0.16, 1, 0.3, 1"
          "tehtarik, 0.48, 1.05, 0.165, 1.35"
          "overshot, 0.13, 0.99, 0.29, 1.1"
          "smoothOut, 0.36, 0, 0.66, -0.56"
          "smoothIn, 0.25, 1, 0.5, 1"
        ];
        animation = [
          "windows, 1, 5, overshot, slide"
          "border, 1, 10, default"
          "fade, 1, 10, default"
          "workspaces, 1, 5, overshot, slidevert"
        ];
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master.new_is_master = false;
      gestures.workspace_swipe = false;
      misc = {
        vfr = true;
        enable_swallow = true;
        swallow_regex = "^(?:Alacritty|kitty)$";
      };
      plugin.hyprwinwrap.class = winWrapClass;
      windowrulev2 = [
        "float,class:^(firefox)$,title:^(Picture-in-Picture)$"
        "float,title:^(ssh-askpass)$"
        "float,class:^(org.kde.polkit-kde-authentication-agent-1)$"
        "float,class:^(firefox)$,title:^(?:Firefox — Sharing Indicator|Firefox — Indicador de compartilhamento)$"
        "move 931 1049,class:^(firefox)$,title:^(?:Firefox — Sharing Indicator|Firefox — Indicador de compartilhamento)$"
        "opacity 0.98 0.95,class:^(?:Code|VSCodium|codium-url-handler|WebCord|code-url-handler|discord|vesktop)$"
        "windowdance,title:^(Rhythm Doctor)$"
      ];
      "$mainMod" = "SUPER";
      bind = [
        # Custom Keybinds
        "$mainMod, Return, exec, ${terminal}"
        "$mainMod, B, exec, ${browser}"
        "$mainMod, V, exec, ${mainEditor}"
        "$mainMod SHIFT, C, killactive,"
        "$mainMod SHIFT, Q, exit,"
        "$mainMod, F, togglefloating,"
        "$mainMod SHIFT, F, fullscreen,"
        "$mainMod, P, exec, rofi -show run"
        "$mainMod, Space, exec, rofi -show drun"
        "ALT,Tab,cyclenext,"
        "ALT,Tab,bringactivetotop,"
        ", Print, exec, grimblast copy area"
        "$mainMod SHIFT, K, exec, hyprctl kill"
        # Move focus with arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ] ++ (
        builtins.concatLists (
          builtins.genList (
            x: [
              "$mainMod, ${toString (x + 1)}, workspace, ${toString (x + 1)}"
              "$mainMod SHIFT, ${toString (x + 1)}, movetoworkspace, ${toString(x + 1)}"
            ]
          ) 9
        )
      );
      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
