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

            lsp = {
              angular.binary = {
                path = lib.getExe pkgs.angular-language-server;
                arguments = [ "--stdio" ];
              };
              dockerfile-language-server.binary = {
                path = lib.getExe pkgs.dockerfile-language-server;
                arguments = [ "--stdio" ];
              };
              compose-language-service.binary.path = lib.getExe pkgs.docker-compose-language-service;
              vscode-css-language-server.binary = {
                path = lib.getExe pkgs.vscode-css-languageserver;
                arguments = [ "--stdio" ];
              };
              json-language-server.binary = {
                path = lib.getExe pkgs.vscode-json-languageserver;
                arguments = [ "--stdio" ];
              };
              tailwindcss-language-server = {
                binary.path = lib.getExe pkgs.tailwindcss-language-server;
                settings.tailwindCSS.emmetCompletions = true;
              };
              emmet-language-server.binary = {
                path = lib.getExe pkgs.emmet-language-server;
                arguments = [ "--stdio" ];
              };
              phpactor.binary = {
                path = lib.getExe pkgs.phpactor;
                arguments = [ "language-server" ];
              };
              jdtls.binary.path = lib.getExe pkgs.jdt-language-server;
              kotlin-language-server.binary.path = lib.getExe pkgs.kotlin-language-server;
              neocmakelsp.binary.path = lib.getExe pkgs.neocmakelsp;
              just-lsp.binary.path = lib.getExe pkgs.just-lsp;
              haskell-language-server.binary.path = lib.getExe' pkgs.haskell-language-server "haskell-language-server-wrapper";
              qmlls.binary.path = lib.getExe' pkgs.qt6.qtdeclarative "qmlls";
              yaml-language-server.binary = {
                path = lib.getExe pkgs.yaml-language-server;
                arguments = [ "--stdio" ];
              };
              wgsl-analyzer.binary.path = lib.getExe pkgs.wgsl-analyzer;
              tofu-ls.binary.path = lib.getExe pkgs.tofu-ls;
              slangd.binary.path = lib.getExe' pkgs.shader-slang "slangd";
              mesonlsp.binary.path = lib.getExe pkgs.mesonlsp;
              bash-language-server.binary.path = lib.getExe pkgs.bash-language-server;
              marksman.binary.path = lib.getExe pkgs.marksman;
              tombi.binary = {
                path = lib.getExe pkgs.tombi;
                arguments = [ "lsp" ];
              };
              cargo-tom.initialization_options.hide_docs_info_message = true;
              nixd = {
                initialization_options.formatting.command = [
                  (lib.getExe pkgs.nixfmt)
                  "-q"
                ];
                binary.path = lib.getExe pkgs.nixd;
              };
              biome.binary = {
                path = lib.getExe pkgs.biome;
                arguments = [ "lsp-proxy" ];
              };
              deno.binary = {
                path = lib.getExe pkgs.deno;
                arguments = [ "lsp" ];
              };
              vtsls.binary = {
                path = lib.getExe pkgs.vtsls;
                arguments = [ "--stdio" ];
              };
              basedpyright.binary.path = lib.getExe pkgs.basedpyright;
              ruff.binary = {
                path = lib.getExe pkgs.ruff;
                arguments = [ "server" ];
              };
              ty.binary = {
                path = lib.getExe pkgs.ty;
                arguments = [ "server" ];
              };
              rust-analizer = {
                binary.path = lib.getExe pkgs.rust-analyzer;
                initialization_options.check.command = "clippy";
              };
              zls.binary.path = lib.getExe pkgs.zls;

              clangd.binary.path_lookup = true;
              eslint.binary.path_lookup = true;
              svelte-language-server.binary.path_lookup = true;
            };

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
            title_bar.show_branch_icon = true;
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

            hour_format = "hour24";
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
