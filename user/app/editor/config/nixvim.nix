{
  enableMan = true;
  viAlias = true;
  vimAlias = true;

  options = {
    number = true;
    relativenumber = true;
    shiftwidth = 2;
  };

  globals = { mapleader = " "; };

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
    flavour = "mocha";
    terminalColors = true;
    transparentBackground = false;
  };

  plugins = {
    lualine.enable = true;
    neocord.enable = true;
    noice.enable = true;
    # hardtime.enable = true;
    rainbow-delimiters.enable = true;
    rust-tools.enable = true;
    telescope.enable = true;
    treesitter.enable = true;
    which-key.enable = true;
    oil = {
      enable = true;
      viewOptions.showHidden = true;
    };
    luasnip.enable = true;
    nvim-colorizer.enable = true;
    nvim-autopairs.enable = true;
    nvim-lightbulb.enable = true;
    lsp-format.enable = true;
    # nvim-ufo.enable = true;
    auto-save = {
      enable = true;
      condition = ''
        function(buf)
          local fn = vim.fn
          local utils = require("auto-save.utils.data")
          if
              fn.getbufvar(buf, "&modifiable") == 1 and
              utils.not_in(fn.getbufvar(buf, "&filetype"), { "oil" }) then
            return true
          end
          return false
        end
      '';
    };
    cmp = {
      enable = true;
      autoEnableSources = true;

      settings = {
        snippet.expand =
          "function(args) require('luasnip').lsp_expand(args.body) end";
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
          "<S-Tab>" = {
            action = ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end
            '';
            modes = [ "i" "s" ];
          };
        };
      };
    };
    none-ls = {
      enable = true;
      updateInInsert = true;
      enableLspFormat = true;
      sources = {
        diagnostics = { stylelint.enable = true; };
        formatting = {
          gofmt.enable = true;
          goimports.enable = true;
          markdownlint.enable = true;
          nixfmt.enable = true;
          prettierd = {
            enable = true;
            withArgs = ''
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
        tsserver.enable = true;
        yamlls.enable = true;
        typst-lsp.enable = true;
        tailwindcss.enable = true;
        svelte.enable = true;
        rust-analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
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
  };
}
