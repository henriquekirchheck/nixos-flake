{
  config,
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
      "catppuccin"
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

    # Everything inside of these brackets are Zed options
    userSettings = {
      lsp = {
        angular.binary.path = lib.getExe pkgs.angular-language-server;
        dockerfile-language-server.binary.path = lib.getExe pkgs.dockerfile-language-server;
        compose-language-service.binary.path = lib.getExe pkgs.docker-compose-language-service;
        vscode-css-language-server.binary.path = lib.getExe pkgs.vscode-css-languageserver;
        vscode-html-language-server.binary.path = lib.getExe' pkgs.vscode-langservers-extracted "vscode-html-language-server";
        json-language-server.binary.path = lib.getExe pkgs.vscode-json-languageserver;
        tailwindcss-language-server = {
          binary.path = lib.getExe pkgs.tailwindcss-language-server;
          settings.tailwindCSS.emmetCompletions = true;
        };
        emmet-language-server.binary.path = lib.getExe pkgs.emmet-language-server;
        phpactor.binary.path = lib.getExe pkgs.phpactor;
        jdtls.binary.path = lib.getExe pkgs.jdt-language-server;
        kotlin-language-server.binary.path = lib.getExe pkgs.kotlin-language-server;
        neocmakelsp.binary.path = lib.getExe pkgs.neocmakelsp;
        just-lsp.binary.path = lib.getExe pkgs.just-lsp;
        haskell-language-server.binary.path = lib.getExe pkgs.haskell-language-server;
        qmlls.binary.path = lib.getExe' pkgs.qt6.qtdeclarative "qmlls";
        yaml-language-server.binary.path = lib.getExe pkgs.yaml-language-server;
        wgsl-analyzer.binary.path = lib.getExe pkgs.wgsl-analyzer;
        tofu-ls.binary.path = lib.getExe pkgs.tofu-ls;
        slangd.binary.path = lib.getExe' pkgs.shader-slang "slangd";
        mesonlsp.binary.path = lib.getExe pkgs.mesonlsp;
        bash-language-server.binary.path = lib.getExe pkgs.bash-language-server;
        marksman.binary.path = lib.getExe pkgs.marksman;
        tombi.binary.path = lib.getExe pkgs.tombi;
        nixd = {
          initialization_options.formatting.command = [
            (lib.getExe pkgs.nixfmt)
            "-q"
          ];
          binary.path = lib.getExe pkgs.nixd;
        };
        biome.binary.path = lib.getExe pkgs.biome;
        deno.binary.path = lib.getExe pkgs.deno;
        vtsls.binary.path = lib.getExe pkgs.vtsls;
        basedpyright.binary.path = lib.getExe pkgs.basedpyright;
        ruff.binary.path = lib.getExe pkgs.ruff;
        ty.binary.path = lib.getExe pkgs.ty;
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
      };

      auto_indent_on_paste = false;
      autosave = {
        after_delay = {
          milliseconds = 500;
        };
      };
      autoscroll_on_clicks = true;
      base_keymap = "VSCode";
      bottom_dock_layout = "contained";
      buffer_font_family = "JetBrainsMono Nerd Font";
      buffer_font_features = {
        calt = true;
      };
      buffer_font_size = 15;
      collaboration_panel = {
        button = true;
      };
      colorize_brackets = true;
      diagnostics = {
        inline = {
          enabled = true;
        };
      };
      disable_ai = true;
      file_types = {
        env = [ "*.env.*" ];
        typst = [ "*.typst" ];
      };
      icon_theme = "Catppuccin Mocha";
      indent_guides = {
        coloring = "indent_aware";
      };
      inlay_hints = {
        enabled = true;
      };
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
        hide_hidden = true;
        hide_root = true;
      };
      search = {
        center_on_match = true;
      };
      show_edit_predictions = false;
      sticky_scroll = {
        enabled = true;
      };
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
        diagnostics = true;
        metrics = false;
      };
      terminal = {
        cursor_shape = "bar";
        font_family = "JetBrainsMono Nerd Font";
        max_scroll_history_lines = 100000;
      };
      theme = "Catppuccin Mocha";
      title_bar = {
        show_branch_icon = true;
      };
      toolbar = {
        agent_review = false;
        code_actions = true;
      };
      ui_font_family = "JetBrainsMono Nerd Font";
      ui_font_size = 15;
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
  };

}
