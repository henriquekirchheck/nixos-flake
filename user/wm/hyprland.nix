{ config, pkgs, lib, terminal, browser, mainEditor, ... }:

{
  imports = [
    ../app/browser/${browser}.nix
    ../app/terminal/${terminal}.nix
    ../app/editor/${mainEditor}.nix
    ../app/utils/rofi/rofi.nix
    ../app/utils/dunst.nix
    ../app/utils/waybar.nix
  ];

  gtk.cursorTheme = {
    package = pkgs.phinger-cursors;
    name = "phinger-cursors-light";
    size = 24;
  };

  home.packages = with pkgs; [ grimblast swww ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    enableNvidiaPatches = true;
    systemd.enable = true;
    settings = {};
    extraConfig = ''
      env = LIBVA_DRIVER_NAME,nvidia
      env = XDG_SESSION_TYPE,wayland
      env = GBM_BACKEND,nvidia-drm
      env = __GLX_VENDOR_LIBRARY_NAME,nvidia
      env = WLR_NO_HARDWARE_CURSORS,1
      env = XCURSOR_SIZE,24
      env = QT_QPA_PLATFORM,wayland
      env = QT_QPA_PLATFORMTHEME,qt6ct
      env = MOZ_ENABLE_WAYLAND,1
      env = MOZ_DRM_DEVICE,/dev/dri/renderD128

      exec-once = swww init
      exec-once = waybar
      exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once = dbus-launch --exit-with-session
      exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once = /usr/lib/polkit-kde-authentication-agent-1
      exec-once = dunst
      exec-once = hyprctl setcursor ${config.gtk.cursorTheme.name} ${builtins.toString config.gtk.cursorTheme.size}
      exec-once = discord-canary --start-minimized

      input {
          kb_layout = br
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =

          follow_mouse = 1

          touchpad {
              natural_scroll = false
          }

          numlock_by_default = true
          sensitivity = 0
      }

      general {
          gaps_in = 4
          gaps_out = 4
          border_size = 2
          col.active_border = rgb(b48ead)
          col.inactive_border = rgb(4c566a)

          layout = dwindle
      }

      decoration {
          rounding = 5

          blur {
              enabled = true
              size = 3
              passes = 2
              new_optimizations = true
          }
          #blur = true
          #blur_size = 3
          #blur_passes = 2
          #blur_new_optimizations = true

          drop_shadow = true
          shadow_range = 2
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
      }

      animations {
          enabled = true

        bezier = simple, 0.16, 1, 0.3, 1
        bezier = tehtarik, 0.48, 1.05, 0.165, 1.35
        bezier = overshot, 0.13, 0.99, 0.29, 1.1
        bezier = smoothOut, 0.36, 0, 0.66, -0.56
        bezier = smoothIn, 0.25, 1, 0.5, 1

        animation = windows, 1, 5, overshot, slide
        animation = border, 1, 10, default
        animation = fade, 1, 10, default
        animation = workspaces, 1, 5, overshot, slidevert
      }

      dwindle {
          pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true # you probably want this
      }

      master {
          new_is_master = false
      }

      gestures {
          workspace_swipe = false
      }

      misc {
          vfr = true
          enable_swallow = true
          swallow_regex = ^(?:Alacritty|kitty)$
      }

      windowrulev2 = float,class:^(firefox)$,title:^(Picture-in-Picture)$
      windowrulev2 = float,title:^(ssh-askpass)$
      windowrulev2 = float,class:^(org.kde.polkit-kde-authentication-agent-1)$,title:^(Picture-in-Picture)$
      windowrulev2 = float,class:^(firefox)$,title:^(?:Firefox — Sharing Indicator|Firefox — Indicador de compartilhamento)$
      windowrulev2 = move 931 1049,class:^(firefox)$,title:^(?:Firefox — Sharing Indicator|Firefox — Indicador de compartilhamento)$
      windowrulev2 = opacity 0.98 0.95,class:^(?:Code|VSCodium|codium-url-handler|WebCord|code-url-handler|discord)$

      $mainMod = SUPER

      bind = $mainMod, Return, exec, ${terminal}
      bind = $mainMod, B, exec, ${browser}
      bind = $mainMod, V, exec, ${mainEditor}
      bind = $mainMod SHIFT, C, killactive,
      bind = $mainMod SHIFT, Q, exit,
      bind = $mainMod, F, togglefloating,
      bind = $mainMod SHIFT, F, fullscreen,
      bind = $mainMod, P, exec, rofi -show run
      bind = $mainMod, Space, exec, rofi -show drun
      bind = ALT,Tab,cyclenext,
      bind = ALT,Tab,bringactivetotop,
      bind = , Print, exec, grimblast copy area
      bind = $mainMod SHIFT, K, exec, hyprctl kill

      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow
    '';
  };
}
