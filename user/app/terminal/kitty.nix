{ config, pkgs, lib, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    themeFile = "Catppuccin-Mocha";
    settings = {
      background_opacity = lib.mkForce "0.75";
      disable_ligatures = "cursor";
      cursor_shape = "block";
      scrollback_lines = 10000;
      mouse_hide_wait = 0;
      detect_urls = "yes";
      show_hyperlink_targets = "yes";
      url_style = "straight";
      strip_trailing_spaces = "smart";
      focus_follows_mouse = "no";
      enable_audio_bell = "no";
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_bar_align = "left";
      tab_bar_min_tabs = 2;
      tab_switch_strategy = "previous";
      dynamic_background_opacity = "yes";
      update_check_interval = 0;
      allow_hyperlinks = "yes";
    };
    shellIntegration.mode = "no-sudo";
    keybindings = {
      "ctrl+shift+n" = "new_os_window_with_cwd";
      f1 = "clear_terminal clear active";
    };
  };
}
