{
  enableMan = true;
  viAlias = true;
  vimAlias = true;

  options = {
    number = true;
    relativenumber = true;
    shiftwidth = 2;
  };

  globals = {
    mapleader = " ";
  };

  keymaps = [
    {
      action = "<cmd>Telescope live_grep<CR>";
      key = "<leader>g";
    }
  ];

  clipboard = {
    register = "unnamedplus";
    providers.wl-copy.enable = true;
  };

  colorschemes.catppuccin = {
    enable = true;
    flavour = "mocha";
    terminalColors = true;
    transparentBackground = true;
  };

  plugins = {
    lualine.enable = true;
    neocord.enable = true;
    auto-save.enable = true;
    noice.enable = true;
    hardtime.enable = true;
    rainbow-delimiters.enable = true;
    rust-tools.enable = true;
    telescope.enable = true;
    treesitter.enable = true;
    which-key.enable = true;
    oil.enable = true;
    luasnip.enable = true;
    nvim-colorizer.enable = true;
    nvim-autopairs.enable = true;
    nvim-lightbulb.enable = true;
    nvim-ufo.enable = true;
    nvim-cmp = {
      enable = true;
      autoEnableSources = true;
      sources = [
        { name = "nvim_lsp"; }
        { name = "path"; }
        { name = "buffer"; }
      ];
    };
    none-ls = {
      enable = true;
      sources = {
        code_actions = {
          eslint.enable = true;
          shellcheck.enable = true;
        };
        diagnostics = {
          eslint.enable = true;
          ruff.enable = true;
          shellcheck.enable = true;
        };
        formatting = {
          eslint.enable = true;
          gofmt.enable = true;
          goimports.enable = true;
          jq.enable = true;
          markdownlint.enable = true;
          nixfmt.enable = true;
          prettier.enable = true;
          ruff.enable = true;
          ruff_format.enable = true;
          rustfmt.enable = true;
          shfmt.enable = true;
        };
      };
    };
    lsp = {
      enable = true;
      servers = {
        tsserver.enable = true;
        yamlls.enable = true;
        typst-lsp.enable = true;
        tailwindcss.enable = true;
        svelte.enable = true;
        rust-analyzer.enable = true;
        ruff-lsp.enable = true;
        pylyzer.enable = true;
        lua-ls.enable = true;
        nil_ls.enable = true;
        jsonls.enable = true;
        html.enable = true;
        gdscript.enable = true;
        eslint.enable = true;
        emmet_ls.enable = true;
        dockerls.enable = true;
        cssls.enable = true;
        clangd.enable = true;
        biome.enable = true;
        bashls.enable = true;
        gopls.enable = true;
      };
    };
    mapping = {
      "<CR>" = "cmp.mapping.confirm({ select = true })";
      "<Tab>" = {
        action = ''
          function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expandable() then
              luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif check_backspace() then
              fallback()
            else
              fallback()
            end
          end
        '';
        modes = [ "i" "s" ];
      };
    };
  };
}