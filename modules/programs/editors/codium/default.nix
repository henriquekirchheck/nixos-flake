{ pkgs, inputs, ... }:

let
  codePackage = pkgs.vscodium;
  codeExtensions = pkgs.nix-vscode-extensions;

  extensionsOpenVSX =
    with codeExtensions.open-vsx;
    with codeExtensions.open-vsx-release;
    [
      catppuccin.catppuccin-vsc-icons
      llvm-vs-code-extensions.vscode-clangd
      rust-lang.rust-analyzer
      tamasfe.even-better-toml
      adpyke.codesnap
      ms-azuretools.vscode-docker
      irongeek.vscode-env
      usernamehw.errorlens
      dbaeumer.vscode-eslint
      vitest.explorer
      eamodio.gitlens
      wix.vscode-import-cost
      christian-kohler.path-intellisense
      esbenp.prettier-vscode
      svelte.svelte-vscode
      ms-python.mypy-type-checker
      ms-python.python
      detachhead.basedpyright
      bradlc.vscode-tailwindcss
      yoavbls.pretty-ts-errors
      christian-kohler.npm-intellisense
      jeanp413.open-remote-ssh
      geequlim.godot-tools
      alfish.godot-files
      jnoortheen.nix-ide
      mkhl.direnv
      mtxr.sqltools
      mtxr.sqltools-driver-pg
      mtxr.sqltools-driver-mysql
      myriad-dreamin.tinymist
      llvm-vs-code-extensions.vscode-clangd
      inlang.vs-code-extension
      charliermarsh.ruff
      jeanp413.open-remote-ssh
      #editorconfig.editorconfig
      ziglang.vscode-zig
      denoland.vscode-deno
      # Java
      #redhat.java
      #vscjava.vscode-java-debug
      #vscjava.vscode-java-test
      #vscjava.vscode-maven
      #vscjava.vscode-gradle
      #vscjava.vscode-java-dependency
      #fwcd.kotlin
      ms-vscode.hexeditor
      hashicorp.terraform
      firefox-devtools.vscode-firefox-debug
      a5huynh.vscode-ron

      # Qt
      theqtcompany.qt-core
      theqtcompany.qt-cpp
      theqtcompany.qt-qml
      theqtcompany.qt-ui

      shader-slang.slang-language-extension

      angular.ng-template
    ];
  extensionsVSCodeMarketplace =
    with codeExtensions.vscode-marketplace;
    with codeExtensions.vscode-marketplace-release;
    [ ];

  extensionsNixpkgs = with pkgs.vscode-extensions; [
    # PHP
    xdebug.php-debug
    bmewburn.vscode-intelephense-client

    vadimcn.vscode-lldb
  ];

  extensions = extensionsOpenVSX ++ extensionsVSCodeMarketplace ++ extensionsNixpkgs;
in
{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin.flavor = "mocha";
  catppuccin.vscode.profiles.default = {
    enable = true;
    accent = "sapphire";
    settings = {
      boldKeywords = true;
      italicComments = true;
      italicKeywords = true;
      extraBordersEnabled = false;
      workbenchMode = "default";
      bracketMode = "rainbow";
      colorOverrides = { };
      customUIColors = { };
    };
  };

  home.packages = with pkgs; [
    typst
    typstyle
  ];

  programs.vscode = {
    enable = true;
    package = codePackage;
    mutableExtensionsDir = false;
    profiles.default = {
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

        "workbench.iconTheme" = "catppuccin-mocha";
        "gopls" = {
          "ui.semanticTokens" = true;
        };

        "editor.fontLigatures" = true;
        "editor.fontFamily" = "JetBrainsMono Nerd Font";
        "terminal.integrated.fontFamily" = "MesloLGS Nerd Font";
        "files.simpleDialog.enable" = false;
        "files.trimTrailingWhitespace" = true;
        "files.readonlyInclude" = {
          "**/.cargo/registry/src/**/*.rs" = true;
          "**/.cargo/git/checkouts/**/*.rs" = true;
          "**/lib/rustlib/src/rust/library/**/*.rs" = true;
        };
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

        "[zig]" = {
          "editor.suggest.insertMode" = "replace";
          "editor.stickyScroll.defaultModel" = "foldingProviderModel";
          "editor.codeActionsOnSave" = {
            "source.fixAll" = "explicit";
            "source.organizeImports" = "explicit";
          };
        };

        "svelte.enable-ts-plugin" = true;
        "[svelte]"."editor.defaultFormatter" = "svelte.svelte-vscode";
        "files.associations" = {
          "*.env.*" = "env";
          "*.typst" = "typst";
        };
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
        "nix.serverPath" = "nixd";

        "godotTools.editorPath.godot4" = "${pkgs.godot_4}/bin/godot4";

        "codesnap.shutterAction" = "copy";
        "codesnap.showLineNumbers" = true;
        "codesnap.realLineNumbers" = false;
        "codesnap.showWindowControls" = false;
        "codesnap.roundedCorners" = true;
        "codesnap.transparentBackground" = true;

        "redhat.telemetry.enabled" = false;
        "java.codeGeneration.toString.codeStyle" = "STRING_FORMAT";
        "java.saveActions.organizeImports" = true;

        "tinymist.formatterMode" = "typstyle";

        "sherlock.userId" = "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa";
        "deno.path" = "${pkgs.deno}/bin/deno";

        "kotlin.languageServer.enabled" = true;
        "kotlin.languageServer.path" = "${pkgs.kotlin-language-server}/bin/kotlin-language-server";
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
  };
}
