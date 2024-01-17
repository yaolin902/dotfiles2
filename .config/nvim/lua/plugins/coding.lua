return {
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
  },

  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
    },
    opts = function()
      vim.g.cmp_enabled = true
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_cmp()

      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snips" } })

      return {
        enabled = function()
          return vim.g.cmp_enabled
        end,
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-j>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "codeium" }
        }, {
          { name = "buffer" },
        }),
        formatting = {
          format = require("lspkind").cmp_format({
            mode = 'symbol',
            maxwidth = 50,
            ellipsis_char = '...',
            symbol_map = { Codeium = "", }
          })
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = defaults.sorting,
      }
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "CRAG666/code_runner.nvim",
    keys = {
      {"<leader>r", "<cmd>RunCode<CR>", desc = "Run Code"},
    },
    opts = {
      mode = "toggleterm",
      filetype = {
        python = "python3 -u",
      },
    },
  },
  {
    "folke/zen-mode.nvim",
    keys = {
      {"<leader>z", "<cmd>ZenMode<CR>", desc = "Zen Mode"},
    },
    opts = {
      window = {
        backdrop = 1,
        options = {
          signcolumn = "no",
          foldcolumn = "0",
          cursorcolumn = false,
          cursorline = false,
          relativenumber = false,
        },
      },
      plugins = {
        tmux = { enabled = true },
      },
      on_open = function(win)
        vim.opt.colorcolumn = "0"
        vim.diagnostic.hide()
        vim.opt.list = false
        vim.cmd([[IBLToggle]])
        vim.g.cmp_enabled = false
      end,
      on_close = function()
        vim.opt.colorcolumn = "80"
        vim.diagnostic.show()
        vim.opt.list = true
        vim.cmd([[IBLToggle]])
        vim.g.cmp_enabled = true
      end,
    },
  },
  {"mg979/vim-visual-multi"},
}
