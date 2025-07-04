{ pkgs, ... }:
{
  services.dunst = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
      size = "32x32";
    };
    settings = {
      global = {
        monitor = 0;
        follow = "mouse";
        width = "350";
        offset = "20x50";
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 400;
        indicate_hidden = "yes";
        shrink = "no";
        separator_height = 2;
        padding = 8;
        horizontal_padding = 8;
        text_icon_padding = 0;
        frame_width = 2;
        frame_color = "#4A5057";
        separator_color = "frame";
        sort = "yes";
        idle_threshold = 120;
        font = "JetBrains Mono Nerd Font Medium 10";
        line_height = 0;
        markup = "full";
        format = "<b>%s</b>\n%b";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        word_wrap = "yes";
        ellipsize = "middle";
        ignore_newline = "no";
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = "yes";
        icon_position = "left";
        min_icon_size = 0;
        max_icon_size = 32;
        sticky_history = "yes";
        history_length = 20;
        always_run_script = true;
        title = "Dunst";
        class = "Dunst";
        ignore_dbusclose = false;
        force_xwayland = false;
        force_xinerama = false;
        mouse_left_click = "do_action, close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
      };
      experimental.per_monitor_dpi = false;

      urgency_low = {
        background = "#11121D";
        foreground = "#A0A8CD";
        timeout = 10;
      };
      urgency_normal = {
        background = "#11121D";
        foreground = "#A0A8CD";
        timeout = 10;
      };
      urgency_critical = {
        background = "#11121D";
        foreground = "#EE6D85";
        timeout = 30;
      };
    };
  };
}
