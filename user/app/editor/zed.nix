{ pkgs, lib, ... }:

{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "make"
      "html"
      "catppuccin"
      "catppuccin-icons"
      "emmet"
      "glsl"
      "proto"
      "ruff"
      "snippets"
      "java"
      "dockerfile"
      "git-firefly"
      "sql"
      "svelte"
      "zig"
      "docker-compose"
      "kotlin"
      "biome"
      "env"
      "deno"
      "haskell"
      "basher"
      "discord-presence"
      "basedpyright"
      "cargo-tom"
    ];

    userSettings = {
      assistant = {enabled = false; version = "2";};
      node = {
        path = lib.getExe pkgs.nodejs;
        npm_path = lib.getExe' pkgs.nodejs "npm";
      };
      hour_format = "hour24";
      auto_update = false;
      terminal = {
        copy_on_select = false;
        dock = "bottom";
        detect_venv.on = {
          directories = [ ".env" "env" ".venv" "venv" ];
          activate_script = "default";
        };
        font_family = "MesloLGS Nerd Font";
        shell = "system";
        working_directory = "current_project_directory";
        toolbar.breadcrumbs = true;
        line_height = "standard";
      };
      lsp = {
        rust-analyzer.binary.path_lookup = true;
        nix.binary.path_lookup = true;
      };
      load_direnv = "shell_hook";
      base_keymap = "VSCode";
      theme = {
        mode = "dark";
        light = "Catppuccin Latte";
        dark = "Catppuccin Mocha";
      };
      show_whitespaces = "selection";
      autosave.after_delay.milliseconds = 100;
      buffer_font_family = "JetBrainsMono Nerd Font";
      buffer_line_height = "standard";
      tabs = {
        file_icons = false;
        git_status = false;
        show_close_button = "hidden";
      };
      features.edit_prediction_provider = "none";
      format_on_save = "on";
      diagnostics.inline = {
        enabled = true;
        max_severity = "warning";
      };
      icon_theme = {
        mode = "dark";
        light = "Catppuccin Latte";
        dark = "Catppuccin Mocha";
      };
      inlay_hints.enabled = true;
      preview_tabs = {
        enabled = true;
        enable_preview_from_file_finder = true;
        enable_preview_from_code_navigation = true;
      };
      show_call_status_icon = false;
      tab_size = 2;
      current_line_highlight = "none";
      project_panel = {
        dock = "right";
        entry_spacing = "standard";
      };
    };
  };
}
