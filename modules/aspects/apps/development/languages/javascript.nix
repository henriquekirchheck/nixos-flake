{
  den.aspects.apps.development.languages.javascript = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        deno
        nodejs
        pnpm
        oxlint
        oxfmt
        biome
        # typescript-language-server
      ];
    };

    zed-extensions = _: [
      "biome"
      "oxc"
      "deno"
    ];
    zed-settings = _: [
      {
        lsp.vtsls = {
          enable_lsp_tasks = true;
          settings."js/ts" = {
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
        };
        lsp.deno.settings.suggest = {
          completeFunctionCalls = true;
          names = true;
          paths = true;
          autoImports = true;
          imports = {
            autoDiscover = true;
            hosts = true;
          };
        };
      }
      {
        lsp.json-language-server.settings.json.schemas = [
          {
            fileMatch = [
              "deno.json"
              "deno.jsonc"
            ];
            url = "https://raw.githubusercontent.com/denoland/deno/refs/heads/main/cli/schemas/config-file.v1.json";
          }
          {
            fileMatch = [ "package.json" ];
            url = "https://www.schemastore.org/package";
          }
        ];
      }
    ];
    cacheHome = _: {
      directories = [
        ".local/share/pnpm"
        ".local/state/pnpm"
      ];
    };
  };
}
