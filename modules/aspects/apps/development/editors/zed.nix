{ den, __findFile, ... }:
{
  den.quirks = {
    zed-extensions.description = "Extensions to automatically install on zed";
    zed-settings.description = "Settings to apply on zed";
  };

  den.aspects.apps.development.editors.zed = {
    includes = [
      <apps/development/editors/zed/collect>
      (den.lib.policy.when (
        { host, ... }: host.hasAspect <stylix.module>
      ) <apps/development/editors/zed/stylix/disable>)
    ];

    zed-extensions = _: [
      "env"
      "log"
      "ini"
      "csv"
      "xml"
      "http"
      "toml"
      "json5"
      "jsonl"
      "jsonnet"

      "catppuccin"
      "catppuccin-icons"
    ];

    homeManager = { lib, pkgs, ... }: {
      programs.zed-editor = {
        enable = true;
        mutableUserDebug = false;
        mutableUserKeymaps = false;
        mutableUserSettings = false;
        mutableUserTasks = false;

        userSettings = {
          disable_ai = true;

          auto_update = false;
          base_keymap = "VSCode";
          hide_mouse = "never";
          text_rendering_mode = "platform_default";
          scrollbar.show = "auto";
          completion_menu_scrollbar = "auto";
          lsp_document_colors = "background";
          bottom_dock_layout = "contained";
          buffer_line_height = "standard";
          load_direnv = "shell_hook";
          cli_default_open_behavior = "new_window";
          on_last_window_closed = "quit_app";
          when_closing_with_no_tabs = "keep_window_open";
          format_on_save = "on";
          buffer_font_family = "JetBrainsMono Nerd Font";
          buffer_font_features.calt = true;
          auto_indent_on_paste = true;
          use_system_prompts = false;
          use_system_path_prompts = false;
          vim.use_smartcase_find = true;
          vim_mode = true;
          diagnostics.inline.enabled = true;
          git.inline_blame.show_commit_summary = true;
          selection_highlight = true;
          rounded_selection = true;
          search.regex = true;
          use_smartcase_search = true;
          colorize_brackets = true;
          inlay_hints.enabled = true;
          auto_signature_help = true;
          inline_code_actions = true;
          search.center_on_match = true;
          show_edit_predictions = false;
          sticky_scroll.enabled = true;
          hover_popover_delay = 250;
          autosave.after_delay.milliseconds = 500;
          tab_size = 2;
          indent_guides = {
            background_coloring = "disabled";
            active_line_width = 2;
            line_width = 1;
            coloring = "indent_aware";
          };

          agent.button = false;
          collaboration_panel.button = false;
          debugger.dock = "left";
          outline_panel.dock = "left";
          git_panel = {
            dock = "left";
            file_icons = true;
            show_count_badge = true;
          };
          project_panel = {
            dock = "left";
            hide_gitignore = false;
            hide_hidden = false;
            hide_root = true;
            folder_icons = true;
            file_icons = true;
            git_status_indicator = true;
            bold_folder_labels = true;
            diagnostic_badges = true;
            indent_size = 10.0;
          };

          node = {
            path = lib.getExe pkgs.nodejs;
            npm_path = lib.getExe' pkgs.nodejs "npm";
          };
          prettier.allowed = false;

          icon_theme = {
            mode = "system";
            light = "Catppuccin Latte";
            dark = "Catppuccin Mocha";
          };
          theme = {
            mode = "system";
            light = "Catppuccin Latte";
            dark = "Catppuccin Mocha";
          };

          window_decorations = "server";
          tab_bar = {
            show = true;
            show_tab_bar_buttons = false;
            show_nav_history_buttons = false;
            show_pinned_tabs_in_separate_row = false;
          };
          tabs = {
            file_icons = true;
            show_close_button = "hidden";
            show_diagnostics = "all";
            git_status = true;
          };
          title_bar = {
            button_layout = "";
            show_menus = false;
            show_sign_in = false;
            show_user_menu = false;
            show_user_picture = false;
            show_branch_status_icon = true;
          };
          status_bar = {
            show_active_file = false;
            active_encoding_button = "enabled";
            active_laguage_button = true;
          };
          toolbar = {
            code_actions = true;
            agent_review = false;
          };
          minimap = {
            show = "auto";
            thumb = "hover";
            thumb_border = "full";
            display_in = "active_editor";
            max_width_columns = 80;
            current_line_highlight = "all";
          };
          which_key = {
            enabled = true;
            delay_ms = 100;
          };
          terminal = {
            cursor_shape = "bar";
            font_size = 15.0;
            font_family = "JetBrainsMono Nerd Font";
            show_count_badge = true;
            toolbar.breadcrumbs = false;
            max_scroll_history_lines = 100000;
            env."GIT_EDITOR" = "zeditor --wait";
          };
          telemetry = {
            diagnostics = false;
            metrics = false;
          };
        };
        userKeymaps = [
          {
            bindings.ctrl-q = null;
          }
          {
            bindings.ctrl-q = "editor::ToggleComments";
            context = "Editor";
          }
          {
            bindings.ctrl-alt-shift-down = [
              "editor::AddSelectionBelow"
              { skip_soft_wrap = true; }
            ];
            context = "Editor";
          }
          {
            bindings.alt-shift-down = "editor::DuplicateLineDown";
            context = "Editor";
          }
          {
            bindings.ctrl-alt-shift-up = [
              "editor::AddSelectionAbove"
              { skip_soft_wrap = true; }
            ];
            context = "Editor";
          }
          {
            bindings.alt-shift-up = "editor::DuplicateLineUp";
            context = "Editor";
          }
        ];
      };
    };
    niri-window-rules = _: [
      {
        matches = [ { app-id = "dev.zed.Zed"; } ];
        opacity = 0.98;
        draw-border-with-background = false;
        background-effect.blur = true;
      }
    ];
    cacheHome = _: {
      directories = [ ".local/share/zed" ];
    };
  };

  den.aspects.apps.development.editors.zed.collect = {
    homeManager =
      {
        zed-extensions,
        zed-settings,
        lib,
        ...
      }:
      {
        programs.zed-editor = {
          extensions = (lib.unique (lib.flatten zed-extensions));
          userSettings = lib.mkMerge zed-settings;
        };
      };
  };

  den.aspects.apps.development.editors.zed.stylix.disable = {
    homeManager.stylix.targets.zed.enable = false;
  };
}
