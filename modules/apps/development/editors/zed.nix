{
  den.aspects.apps.provides.development.provides.editors.provides.zed = {
    homeManager =
      {
        lib,
        pkgs,
        ...
      }:
      {
        programs.zed-editor = {
          enable = true;
          installRemoteServer = true;

          mutableUserDebug = false;
          mutableUserKeymaps = false;
          mutableUserSettings = false;
          mutableUserTasks = false;

          extensions = [
            "angular"
            "awk"
            "biome"
            "caddyfile"
            "catppuccin-icons"
            "cargo-tom"
            "deno"
            "dockerfile"
            "docker-compose"
            "emmet"
            "html"
            "git-firefly"
            "java"
            "php"
            "sql"
            "svelte"
            "xml"
            "kotlin"
            "neocmake"
            "ini"
            "haskell"
            "gdscript"
            "lua"
            "just"
            "just-ls"
            "qml"
            "json5"
            "wgsl-wesl"
            "ass"
            "opentofu"
            "github-actions"
            "jq"
            "slang"
            "editorconfig"
            "meson"
            "basher"
            "marksman"
            "nix"
            "toml"
            "tombi"
            "make"
            "zig"
          ];

          userSettings = {
            disable_ai = true;

            languages = {
              "JavaScript".formatter.code_action = "source.fixAll.eslint";
              "TypeScript".formatter.code_action = "source.fixAll.eslint";
              "Nix".language_servers = [
                "nixd"
                "!nil"
              ];
            };

            auto_indent_on_paste = false;
            autosave.after_delay.milliseconds = 500;
            autoscroll_on_clicks = true;
            base_keymap = "VSCode";
            bottom_dock_layout = "contained";
            buffer_font_features.calt = true;
            collaboration_panel.button = true;
            colorize_brackets = true;
            diagnostics.inline.enabled = true;
            file_types = {
              env = [ "*.env.*" ];
              typst = [ "*.typst" ];
            };
            icon_theme = "Catppuccin Mocha";
            indent_guides.coloring = "indent_aware";
            inlay_hints.enabled = true;
            inline_code_actions = true;
            minimap = {
              display_in = "active_editor";
              show = "auto";
              thumb = "hover";
              thumb_border = "full";
            };
            project_panel = {
              auto_fold_dirs = false;
              dock = "right";
              hide_gitignore = false;
              hide_hidden = false;
              hide_root = true;
            };
            search.center_on_match = true;
            show_edit_predictions = false;
            sticky_scroll.enabled = true;
            tab_bar = {
              show = true;
              show_nav_history_buttons = false;
              show_tab_bar_buttons = true;
            };
            tab_size = 2;
            tabs = {
              close_position = "right";
              file_icons = true;
              git_status = true;
              show_close_button = "hidden";
            };
            telemetry = {
              diagnostics = false;
              metrics = false;
            };
            terminal = {
              cursor_shape = "bar";
              max_scroll_history_lines = 100000;
            };
            title_bar.show_branch_status_icon = true;
            toolbar = {
              agent_review = false;
              code_actions = true;
            };
            ui_font_weight = 300;
            use_on_type_format = false;
            use_smartcase_search = true;
            use_system_path_prompts = true;
            window_decorations = "server";

            node = {
              path = lib.getExe pkgs.nodejs;
              npm_path = lib.getExe' pkgs.nodejs "npm";
            };

            auto_update = false;

            load_direnv = "shell_hook";
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
  };
}
