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
            "html"
            "emmet"
            "angular"
            "biome"
            "oxc"
            "deno"
            "caddyfile"
            "cargo-tom"
            "dockerfile"
            "docker-compose"
            "git-firefly"
            "java"
            "sql"
            "csv"
            "mermaid"
            "log"
            "svelte"
            "xml"
            "neocmake"
            "ini"
            "haskell"
            "gdscript"
            "lua"
            "qml"
            "json5"
            "jsonl"
            "jsonnet"
            "wgsl-wesl"
            "slang"
            "hlsl"
            "glsl"
            "opentofu"
            "github-actions"
            "jq"
            "meson"
            "basher"
            "marksman"
            "rumdl"
            "nix"
            "toml"
            "tombi"
            "make"
            "zig"
            "ansible"
            "csharp"
            "pyrefly"
            "env"
            "http"
            "ssh-config"
            "typst"
            "nginx"
            "latex"

            "catppuccin-icons"
          ];

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
              hide_gitignore = true;
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
              path = lib.getExe pkgs.nodejs_latest;
              npm_path = lib.getExe' pkgs.nodejs_latest "npm";
            };
            prettier.allowed = false;

            icon_theme = {
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

            lsp = {
              vtsls = {
                enable_lsp_tasks = true;
                binary = {
                  path = lib.getExe pkgs.vtsls;
                  arguments = [ "--stdio" ];
                };
                settings =
                  let
                    shared = {
                      updateImportsOnFileMove.enabled = "always";
                      suggest = {
                        enabled = true;
                        paths = true;
                        autoImports = true;
                        includeCompletionsForImportStatements = true;
                      };
                      validade.enable = true;
                      autoClosingTags = true;
                    };
                  in
                  {
                    javascript = shared;
                    typescript = shared;
                  };
              };
              tailwindcss-language-server = {
                binary = {
                  path = lib.getExe pkgs.tailwindcss-language-server;
                  arguments = [ "--stdio" ];
                };
                settings = {
                  includeLanguages = {
                    svelte = "html";
                  };
                  emmetCompletions = true;
                  experimental = {
                    classRegex = [
                      "class=\"([^\"]*)\""
                      "class='([^']*)'"
                      "class:\\s*([^\\s{]+)"
                      "class=\\\"([^\\\"]*)\\\""
                      "@class\\(\\[([^\\]]*)\\]\\)"
                      ":class=\"([^\"]*)\""
                      ":class='([^']*)'"
                      "\\{\\s*class:\\s*\"([^\"]*)\""
                      "\\{\\s*class:\\s*'([^']*)'"
                      "\\.className\\s*[+]?=\\s*['\"]([^'\"]*)['\"]"
                      "\\.setAttributeNS\\(.*,\\s*['\"]class['\"],\\s*['\"]([^'\"]*)['\"]"
                      "\\.setAttribute\\(['\"]class['\"],\\s*['\"]([^'\"]*)['\"]"
                      "\\.classList\\.add\\(['\"]([^'\"]*)['\"]"
                      "\\.classList\\.remove\\(['\"]([^'\"]*)['\"]"
                      "\\.classList\\.toggle\\(['\"]([^'\"]*)['\"]"
                      "\\.classList\\.contains\\(['\"]([^'\"]*)['\"]"
                      "\\.classList\\.replace\\(\\s*['\"]([^'\"]*)['\"]"
                      "\\.classList\\.replace\\([^,)]+,\\s*['\"]([^'\"]*)['\"]"
                    ];
                  };
                };
              };
              yaml-language-server = {
                binary = {
                  path = lib.getExe pkgs.yaml-language-server;
                  arguments = [ "--stdio" ];
                };
              };
              ansible-language-server = {
                binary = {
                  path = lib.getExe pkgs.ansible-language-server;
                  arguments = [ "--stdio" ];
                };
                settings = {
                  ansible.path = lib.getExe' pkgs.ansible "ansible";
                  python.interpreterPath = lib.getExe pkgs.python3;
                  validation = {
                    enabled = true;
                    lint = {
                      enabled = true;
                      path = lib.getExe pkgs.ansible-lint;
                    };
                  };
                };
              };
              oxlint = {
                binary = {
                  path = lib.getExe pkgs.oxlint;
                  arguments = [ "--lsp" ];
                };
                initialization_options.settings = {
                  configPath = null;
                  run = "onType";
                  disableNestedConfig = false;
                  fixKind = "safe_fix";
                  unusedDisableDirectives = "deny";
                };
              };
              oxfmt = {
                binary = {
                  path = lib.getExe pkgs.oxfmt;
                  arguments = [ "--lsp" ];
                };
                initialization_options.settings = {
                  "fmt.configPath" = null;
                  run = "onSave";
                };
              };
              biome = {
                binary = {
                  path = lib.getExe pkgs.biome;
                  arguments = [ "lsp-proxy" ];
                };
                settings.require_config_file = true;
              };
              angular = {
                binary = {
                  path = lib.getExe pkgs.angular-language-server;
                  arguments = [ "--stdio" ];
                };
              };
              emmet-language-server = {
                binary = {
                  path = lib.getExe pkgs.emmet-language-server;
                  arguments = [ "--stdio" ];
                };
              };
              deno = {
                binary = {
                  path = lib.getExe pkgs.deno;
                  arguments = [ "lsp" ];
                };
                settings.suggest = {
                  completeFunctionCalls = true;
                  names = true;
                  paths = true;
                  autoImports = true;
                  imports = {
                    autoDiscover = true;
                    hosts = true;
                  };
                };
              };
              docker-language-server = {
                binary = {
                  path = lib.getExe pkgs.dockerfile-language-server;
                  arguments = [ "--stdio" ];
                };
              };
              docker-compose = {
                binary = {
                  path = lib.getExe pkgs.docker-compose-language-service;
                  arguments = [ "--stdio" ];
                };
              };
              jdtls = {
                binary = {
                  path = lib.getExe pkgs.docker-compose-language-service;
                  arguments = [ "--stdio" ];
                };
                settings = {
                  java_home = "${pkgs.openjdk25}";
                  lombok_support = true;
                  jdk_auto_download = false;

                  check_updates = "never";

                  jdtls_launcher = lib.getBin pkgs.jdt-language-server;
                  lombok_jar = "${pkgs.lombok}/share/java/lombok.jar";
                };
              };
              svelte-language-server = {
                binary = {
                  path = lib.getExe pkgs.svelte-language-server;
                  arguments = [ "--stdio" ];
                };
              };
              cmake = {
                binary = {
                  path = lib.getExe pkgs.neocmakelsp;
                  arguments = [ "stdio" ];
                };
                initialization_options = {
                  format.enable = true;
                  lint.enable = true;
                };
              };
              hls = {
                binary = {
                  path = lib.getExe' pkgs.haskell-language-server "haskell-language-server-wrapper";
                  arguments = [ "--lsp" ];
                };
              };
              lua-language-server = {
                binary.path = lib.getExe pkgs.lua-language-server;
              };
              qmljs = {
                binary.path = lib.getExe' pkgs.qt6Packages.qtdeclarative "qmlls";
              };
              jsonnet = {
                binary.path = lib.getExe pkgs.jsonnet-language-server;
              };
              wgsl_analyzer = {
                binary.path = lib.getExe pkgs.wgsl-analyzer;
              };
              slangd = {
                binary.path = lib.getExe' pkgs.shader-slang "slangd";
              };
              glsl_analyzer = {
                binary.path = lib.getExe pkgs.glsl_analyzer;
              };
              tofu-ls = {
                binary = {
                  path = lib.getExe pkgs.tofu-ls;
                  arguments = [ "serve" ];
                };
              };
              mesonlsp = {
                binary = {
                  path = lib.getExe pkgs.mesonlsp;
                  arguments = [ "--lsp" ];
                };
              };
              bash-language-server = {
                binary = {
                  path = lib.getExe pkgs.bash-language-server;
                  arguments = [ "start" ];
                };
              };
              marksman = {
                binary = {
                  path = lib.getExe pkgs.marksman;
                  arguments = [ "server" ];
                };
              };
              rumdl = {
                binary = {
                  path = lib.getExe pkgs.rumdl;
                  arguments = [ "server" ];
                };
              };
              nil = {
                binary = {
                  path = lib.getExe pkgs.nil;
                  arguments = [ "--stdio" ];
                };
                initialization_options = {
                  formatting.command = [ (lib.getExe pkgs.nixfmt) ];
                  nix.flake = {
                    autoArchive = true;
                    autoEvalInputs = true;
                  };
                };
              };
              nixd = {
                binary.path = lib.getExe pkgs.nixd;
                initialization_options = {
                  formatting.command = [ (lib.getExe pkgs.nixfmt) ];
                  nixpkgs.expr = "import <nixpkgs> { }";
                };
              };
              tombi = {
                binary = {
                  path = lib.getExe pkgs.tombi;
                  arguments = [ "lsp" ];
                };
              };
              zls = {
                binary.path = lib.getExe pkgs.zls;
              };
              clangd = {
                binary.path = lib.getExe' pkgs.clang-tools "clangd";
              };
              roslyn = {
                binary = {
                  path = lib.getExe pkgs.roslyn-ls;
                  arguments = [ "--stdio" ];
                };
              };
              pyrefly = {
                binary = {
                  path = lib.getExe pkgs.pyrefly;
                  arguments = [ "lsp" ];
                };
              };
              ruff = {
                binary = {
                  path = lib.getExe pkgs.ruff;
                  arguments = [ "server" ];
                };
              };
              rust-analyzer = {
                binary.path = lib.getExe pkgs.rust-analyzer;
                enable_lsp_tasks = true;
                initialization_options.rust.analyzerTargetDir = true;
              };
              tinymist = {
                binary = {
                  path = lib.getExe pkgs.tinymist;
                  arguments = [ "lsp" ];
                };
              };
              nginx = {
                binary.path = lib.getExe pkgs.nginx-language-server;
              };
              texlab = {
                binary = {
                  path = lib.getExe pkgs.texlab;
                  arguments = [ "run" ];
                };
              };
            };

            file_types = {
              "Caddyfile" = [
                "Caddyfile*"
                "*.caddyfile"
              ];
              "Dockerfile" = [ "Dockerfile.*" ];
              "GitHub Actions" = [
                ".github/workflows/*.yml"
                ".github/workflows/*.yaml"
                ".forgejo/workflows/*.yml"
                ".forgejo/workflows/*.yaml"
              ];
              "Ansible" = [
                "**.ansible.yml"
                "**.ansible.yaml"
                "**/defaults/*.yml"
                "**/defaults/*.yaml"
                "**/meta/*.yml"
                "**/meta/*.yaml"
                "**/tasks/*.yml"
                "**/tasks/*.yaml"
                "**/handlers/*.yml"
                "**/handlers/*.yaml"
                "**/group_vars/*.yml"
                "**/group_vars/*.yaml"
                "**/playbooks/*.yaml"
                "**/playbooks/*.yml"
                "**playbook*.yaml"
                "**playbook*.yml"
              ];
            };

            languages = {
              "Caddyfile" = {
                tab_size = 2;
                formatter.external = {
                  command = "caddy";
                  arguments = [
                    "fmt"
                    "-c"
                    "-"
                  ];
                };
              };
              "SQL" = {
                formatter.external.command = lib.getBin pkgs.sql-formatter;
              };
              "GDScript" = {
                formatter.external."command" = lib.getExe pkgs.gdscript-formatter;
              };
              "Meson" = {
                language_servers = [
                  "mesonlsp"
                  "!muon"
                ];
              };
              "Shell Script" = {
                formatter.external = {
                  command = lib.getExe pkgs.shfmt;
                  arguments = [
                    "--filename"
                    "{buffer_path}"
                    "--indent"
                    "2"
                  ];
                };
              };
              "Nix" = {
                language_servers = [
                  "!nixd"
                  "nil"
                ];
              };
              "Python" = {
                tab_size = 4;
                language_servers = [
                  "ruff"
                  "pyrefly"
                ];
                code_actions_on_format = {
                  "source.organizeImports.ruff" = true;
                };
                formatter.language_server.name = "ruff";
              };

              "JavaScript".formatter.code_action = "source.fixAll.eslint";
              "TypeScript".formatter.code_action = "source.fixAll.eslint";
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
  };
}
