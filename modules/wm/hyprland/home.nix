{
  pkgs,
  inputs,
  osConfig,
  lib,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package =
      if osConfig.programs.hyprland.enable then
        null
      else
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      if osConfig.programs.hyprland.enable then
        null
      else
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    xwayland.enable = true;
    systemd.variables = [ "--all" ];

    settings = {
      exec-once = [
        "[workspace 8 silent] vesktop"
        "[workspace 2 silent] firefox"
        "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent"

        "waybar"
      ];
      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"

        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      ]
      ++ (
        if osConfig.hardware.nvidia.enabled then
          [
            "LIBVA_DRIVER_NAME,nvidia"
            "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          ]
        else
          [ ]
      );

      monitor = [
        ", preferred, auto, 1"
      ];

      "$mainMod" = "SUPER";
      bind = [
        "$mainMod, Return, exec, kitty"
        "$mainMod, B, exec, firefox"
        "$mainMod, V, exec, codium"
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
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ]
      ++ (builtins.concatLists (
        builtins.genList (x: [
          "$mainMod, ${toString (x + 1)}, workspace, ${toString (x + 1)}"
          "$mainMod SHIFT, ${toString (x + 1)}, movetoworkspace, ${toString (x + 1)}"
        ]) 9
      ));
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      general = {
        gaps_in = 4;
        gaps_out = 4;
        border_size = 2;
        "col.active_border" =
          "rgb(a6e3a1) rgb(94e2d5) rgb(89dceb) rgb(74c7ec) rgb(89b4fa) rgb(b4befe) 270deg";
        "col.inactive_border" = "rgb(181825)";
        layout = "dwindle";
      };
      input = {
        kb_layout = "br";
        touchpad.natural_scroll = false;
        numlock_by_default = true;
        sensitivity = 0;
        follow_mouse = 1;
        float_switch_override_focus = 0;
        accel_profile = "flat";
      };
      decoration = {
        rounding = 8;
        blur = {
          enabled = true;
          xray = true;
          size = 8;
          passes = 3;
          new_optimizations = "on";
          noise = 0.01;
          contrast = 0.9;
          brightness = 0.8;
          popups = true;
        };
        shadow.enabled = false;
      };
      animations = {
        enabled = true;
        bezier = [
          "linear, 0.0, 0.0, 1.0, 1.0"
          "md3_standard, 0.2, 0.0, 0, 1.0"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.05"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "win10, 0, 0, 0, 1"
          "gnome, 0, 0.85, 0.3, 1"
          "funky, 0.46, 0.35, -0.2, 1.2"
          "smoothIn, 0.25, 1.0, 0.5, 1.0"
          "holographic, 0.6, 0.04, 0.98, 0.335"
        ];
        animation = [
          "borderangle, 1, 50, linear, loop"
          "windows, 1, 2, md3_standard, slide"
          "border, 1, 3, smoothIn"
          "fade, 1, 0.0000001, default"
          "workspaces, 1, 4, md3_decel, slidevert"
          "specialWorkspace, 1, 5, overshot, slidefadevert 50%"
        ];
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master.new_status = "master";
      misc = {
        enable_swallow = true;
        swallow_regex = "^(?:Alacritty|kitty)$";
        force_default_wallpaper = 2;
        enable_anr_dialog = false;
      };
      windowrulev2 = [
        "opacity 0.92 0.88,class:^(?:Code|VSCodium|codium-url-handler|code-url-handler|discord|vesktop)$"
        "float,class:^(firefox)$,title:^(Picture-in-Picture)$"
        "opacity 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
        "maxsize 1 1,class:^(xwaylandvideobridge)$"
        "noblur,class:^(xwaylandvideobridge)$"
      ];
    };
  };
}
