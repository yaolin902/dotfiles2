return {
  {
    "nvim-tree/nvim-tree.lua",
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<CR>" },
    },
    opts = {
      disable_netrw = true,
      update_focused_file = {
        enable = true,
      },
      git = {
        enable = true,
        ignore = false,
        timeout = 500,
      },
      diagnostics = {
        enable = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      renderer = {
        highlight_git = true,
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            git = {
              unstaged = "",
              staged = "S",
              unmerged = "",
              renamed = "➜",
              deleted = "",
              untracked = "U",
              ignored = "◌",
            },
            folder = {
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
            },
          },
        },
      },
    },
  },

  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {}
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  {
    "numToStr/Comment.nvim",
    version = nil,
    branch = "master",
    config = true,
  },
  {
    "echasnovski/mini.bufremove",
    event = "VeryLazy",
    keys = {
      { "<leader>c", function(n) require("mini.bufremove").delete(n, false) end },
    },
  },
  {
    'NvChad/nvim-colorizer.lua',
    event = "VeryLazy",
    opts = {},
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { "<leader>sf", "<cmd>Telescope find_files<cr>" },
      { "<leader>st", "<cmd>Telescope live_grep<cr>" },
    },
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      }
    },
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  {
    "mbbill/undotree",
    event = "VeryLazy",
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<CR>" },
    },
    config = function() end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,     desc = "Remote Flash" },
      {
        "R",
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        desc =
        "Treesitter Search"
      },
      {
        "<c-s>",
        mode = { "c" },
        function() require("flash").toggle() end,
        desc =
        "Toggle Flash Search"
      },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-\>]],
        direction = "float",
      })
    end,
  },
}
