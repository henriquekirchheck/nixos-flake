{ config, pkgs, lib, inputs, system, ... }:

let
  codePackage = pkgs.vscodium.fhsWithPackages (ps: with ps; [ rustup zlib openssl.dev pkg-config biome ruff nil ]);
  codeExtensions = inputs.nix-vscode-extensions.extensions.${system};

  extensionsOpenVSX = with codeExtensions.open-vsx; [
    # catppuccin.catppuccin-vsc-icons
    pkief.material-product-icons
    llvm-vs-code-extensions.vscode-clangd
    rust-lang.rust-analyzer
    vadimcn.vscode-lldb
    bungcip.better-toml
    adpyke.codesnap
    serayuzgur.crates
    ms-azuretools.vscode-docker
    irongeek.vscode-env
    usernamehw.errorlens
    dbaeumer.vscode-eslint
    eamodio.gitlens
    mhutchie.git-graph
    ms-vscode.hexeditor
    wix.vscode-import-cost
    ms-vscode.makefile-tools
    ms-vscode.cmake-tools
    christian-kohler.path-intellisense
    esbenp.prettier-vscode
    svelte.svelte-vscode
    ms-python.isort
    ms-python.python
    ms-pyright.pyright
    charliermarsh.ruff
    bradlc.vscode-tailwindcss
    nvarner.typst-lsp
    yoavbls.pretty-ts-errors
    calebfiggers.typst-companion
    christian-kohler.npm-intellisense
    biomejs.biome
    jeanp413.open-remote-ssh
    geequlim.godot-tools
    alfish.godot-files
    jnoortheen.nix-ide
  ];
  extensionsVSCodeMarketplace = with codeExtensions.vscode-marketplace; [];
  extensionsNix = [
    (pkgs.catppuccin-vsc.override {
      accent = "mauve";
      boldKeywords = true;
      italicComments = true;
      italicKeywords = true;
      extraBordersEnabled = false;
      workbenchMode = "default";
      bracketMode = "rainbow";
      colorOverrides = {};
      customUIColors = {};
    })
  ];

  extensions = extensionsOpenVSX ++ extensionsVSCodeMarketplace ++ extensionsNix;
in {
  imports = [ ../utils/electron.nix ];

  programs.vscode = {
    enable = true;
    package = codePackage;
    inherit extensions;
    userSettings = {
      "editor.unicodeHighlight.nonBasicASCII" = false;
      "editor.bracketPairColorization.enabled" = true;
      "editor.tabSize" = 2;
      "editor.inlineSuggest.enabled" = true;
      "editor.codeActionsOnSave" = {
        "source.organizeImports" = "explicit";
      };
      "files.autoSave" = "afterDelay";
      "editor.formatOnPaste" = false;
      "editor.formatOnSave" = true;
      "diffEditor.ignoreTrimWhitespace" = false;

      "workbench.colorTheme" = "Catppuccin Mocha";
      "editor.semanticHighlighting.enabled" = true;
      "terminal.integrated.minimumContrastRatio" = 1;
      "gopls" = {
        "ui.semanticTokens" = true;
      };

      "editor.fontLigatures" = true;
      "editor.fontFamily" = "JetBrainsMono Nerd Font";
      "terminal.integrated.fontFamily" = "MesloLGS Nerd Font";
      "files.simpleDialog.enable" = false;
      "files.trimTrailingWhitespace" = true;
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;
      "explorer.fileNesting.enabled" = true;
      "explorer.compactFolders" = false;
      "explorer.excludeGitIgnore" = false;
      "files.exclude" = {
        "**/.git" = true;
        "**/.svn" = true;
        "**/.hg" = true;
        "**/CVS" = true;
        "**/.DS_Store" = true;
        "**/Thumbs.db" = true;
      };
      "terminal.integrated.scrollback" = 100000;
      "terminal.integrated.defaultProfile.linux" = "zsh";

      "git.enableSmartCommit" = true;
      "git.autofetch" = true;
      "git.confirmSync" = false;
      "gitlens.hovers.annotations.changes" = false;
      "gitlens.hovers.avatars" = false;

      "workbench.sideBar.location" = "right";
      "workbench.productIconTheme" = "material-product-icons";

      "window.titleBarStyle" = "custom";
      "window.menuBarVisibility" = "visible";

      "security.workspace.trust.untrustedFiles" = "open";

      "[javascript][typescript][javascriptreact][typescriptreact][html][css][scss][jsonc][json]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "javascript.suggest.paths" = false;
      "typescript.suggest.paths" = false;
      "javascript.updateImportsOnFileMove.enabled" = "always";
      "typescript.updateImportsOnFileMove.enabled" = "always";
      "css.lint.important" = "warning";
      "scss.lint.important" = "warning";
      "javascript.format.enable" = true;
      "javascript.format.semicolons" = "remove";
      "javascript.preferences.quoteStyle" = "single";
      "javascript.autoClosingTags" = true;
      "javascript.suggest.autoImports" = true;
      "javascript.suggest.enabled" = true;
      "javascript.suggest.includeCompletionsForImportStatements" = true;
      "javascript.validate.enable" = true;
      "typescript.format.enable" = true;
      "typescript.format.semicolons" = "remove";
      "typescript.preferences.quoteStyle" = "single";
      "typescript.autoClosingTags" = true;
      "typescript.suggest.enabled" = true;
      "typescript.suggest.autoImports" = true;
      "typescript.suggest.includeCompletionsForImportStatements" = true;
      "typescript.validate.enable" = true;
      "emmet.includeLanguages" = {
        "postcss" = "css";
      };

      "[rust][python]"."editor.tabSize" = 4;

      "svelte.enable-ts-plugin" = true;
      "svelte.language-server.ls-path" = "${pkgs.nodePackages.svelte-language-server}/bin/svelteserver";
      "[svelte]"."editor.defaultFormatter" = "svelte.svelte-vscode";
      "files.associations"."*.env.*" = "env";
      "path-intellisense.absolutePathToWorkspace" = false;
      "prettier.jsxSingleQuote" = false;
      "prettier.semi" = true;
      "prettier.singleQuote" = false;

      "npm-intellisense.importDeclarationType" = "const";
      "npm-intellisense.importLinebreak" = "\n";
      "npm-intellisense.importQuotes" = "'";
      "npm-intellisense.recursivePackageJsonLookup" = true;
      "npm-intellisense.showBuildInLibs" = true;
      "npm-intellisense.importES6" = true;

      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";

      "godot_tools.editor_path" = "${pkgs.godot_4}/bin/godot4";
      "godot_tools.gdscript_lsp_server_port" = 6005;

      "codesnap.shutterAction" = "copy";
      "codesnap.showLineNumbers" = true;
      "codesnap.realLineNumbers" = false;
      "codesnap.showWindowControls" = false;
      "codesnap.roundedCorners" = true;
      "codesnap.transparentBackground" = true;
    };

    keybindings = [
      {
          key = "shift+alt+down";
          command = "-notebook.cell.copyDown";
          when = "notebookEditorFocused && !inputFocus";
      }
      {
          key = "ctrl+shift+alt+down";
          command = "editor.action.insertCursorBelow";
          when = "editorTextFocus";
      }
      {
          key = "shift+alt+down";
          command = "-editor.action.insertCursorBelow";
          when = "editorTextFocus";
      }
      {
          key = "shift+alt+up";
          command = "-notebook.cell.copyUp";
          when = "notebookEditorFocused && !inputFocus";
      }
      {
          key = "ctrl+shift+alt+up";
          command = "editor.action.insertCursorAbove";
          when = "editorTextFocus";
      }
      {
          key = "shift+alt+up";
          command = "-editor.action.insertCursorAbove";
          when = "editorTextFocus";
      }
      {
          key = "shift+alt+down";
          command = "editor.action.copyLinesDownAction";
          when = "editorTextFocus && !editorReadonly";
      }
      {
          key = "ctrl+shift+alt+down";
          command = "-editor.action.copyLinesDownAction";
          when = "editorTextFocus && !editorReadonly";
      }
      {
          key = "shift+alt+up";
          command = "editor.action.copyLinesUpAction";
          when = "editorTextFocus && !editorReadonly";
      }
      {
          key = "ctrl+shift+alt+up";
          command = "-editor.action.copyLinesUpAction";
          when = "editorTextFocus && !editorReadonly";
      }
      {
          key = "ctrl+q";
          command = "-workbench.action.quit";
      }
      {
          key = "ctrl+q";
          command = "editor.action.blockComment";
          when = "editorTextFocus && !editorReadonly";
      }
      {
          key = "ctrl+shift+a";
          command = "-editor.action.blockComment";
          when = "editorTextFocus && !editorReadonly";
      }
      {
          key = "ctrl+q";
          command = "editor.action.commentLine";
          when = "editorTextFocus && !editorReadonly";
      }
      {
          key = "ctrl+/";
          command = "-editor.action.commentLine";
          when = "editorTextFocus && !editorReadonly";
      }
      {
          key = "ctrl+f5";
          command = "workbench.action.debug.start";
          when = "debuggersAvailable && debugState == 'inactive'";
      }
      {
          key = "f5";
          command = "-workbench.action.debug.start";
          when = "debuggersAvailable && debugState == 'inactive'";
      }
      {
          key = "f5";
          command = "workbench.action.debug.run";
          when = "debuggersAvailable && debugState != 'initializing'";
      }
      {
          key = "ctrl+f5";
          command = "-workbench.action.debug.run";
          when = "debuggersAvailable && debugState != 'initializing'";
      }
    ];
  };
}
