{
  enableMan = false;
  viAlias = true;
  vimAlias = true;

  opts = {
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
      options.desc = "Grep Files";
    }
    {
      action = "<cmd>Telescope find_files<CR>";
      key = "<leader>s";
      options.desc = "Open File";
    }
    {
      action = "<cmd>Oil .<CR>";
      key = "<leader>b";
      options.desc = "Open File Editor";
    }
  ];

  clipboard = {
    register = "unnamedplus";
    providers.wl-copy.enable = true;
  };

  colorschemes.catppuccin = {
    enable = true;
    settings = {
      flavour = "mocha";
      term_colors = true;
      transparent_background = false;
    };
  };

  plugins = {
    lualine.enable = true;
    noice.enable = true;
    rainbow-delimiters.enable = true;
    rustaceanvim.enable = true;
    telescope.enable = true;
    treesitter.enable = true;
    which-key.enable = true;
    web-devicons.enable = true;
    oil = {
      enable = true;
      settings.view_options.show_hidden = true;
    };
    luasnip.enable = true;
    colorizer.enable = true;
    nvim-autopairs.enable = true;
    nvim-lightbulb.enable = true;
    lsp-format.enable = true;
    # nvim-ufo.enable = true;
    cmp = {
      enable = true;
      autoEnableSources = true;

      settings = {
        snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-e>" = "cmp.mapping.close()";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        };
      };
    };
    none-ls = {
      enable = true;
      settings = {
        update_in_insert = true;
      };
      enableLspFormat = true;
      sources = {
        diagnostics = {
          stylelint.enable = true;
        };
        formatting = {
          gofmt.enable = true;
          goimports.enable = true;
          markdownlint.enable = true;
          nixfmt.enable = true;
          prettierd = {
            enable = true;
            disableTsServerFormatter = false;
            settings = ''
              {condition = function(utils)
                              return utils.has_file({ ".prettierrc", ".prettierrc.json", ".prettierrc.yml", ".prettierrc.yaml", ".prettierrc.json5", ".prettierrc.js", "prettier.config.js", ".prettierrc.mjs", "prettier.config.mjs", ".prettierrc.cjs", "prettier.config.cjs", ".prettierrc.toml", })
              	      end,}'';
          };
          shfmt.enable = true;
        };
      };
    };
    lsp = {
      enable = true;
      keymaps.lspBuf = {
        K = "hover";
        gD = "references";
        gd = "definition";
        gi = "implementation";
        gt = "type_definition";
        gr = "rename";
        "<leader>f" = "format";
      };
      servers = {
        ts_ls.enable = true;
        yamlls.enable = true;
        tailwindcss.enable = true;
        svelte.enable = true;
        # rust_analyzer = {
        #   enable = true;
        #   installCargo = true;
        #   installRustc = true;
        # };
        ruff_lsp.enable = true;
        lua_ls.enable = true;
        nil_ls.enable = true;
        jsonls.enable = true;
        html.enable = true;
        gdscript = {
          enable = true;
          package = null;
        };
        eslint.enable = true;
        emmet_ls.enable = true;
        dockerls.enable = true;
        cssls.enable = true;
        clangd.enable = true;
        biome.enable = true;
        gopls.enable = true;
      };
    };
  };
}
