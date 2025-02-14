return {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    optional = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},  -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = {      -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/notes",
                journal = "~/journal",
              },
            },
          },
          ["core.journal"] = {
            config = {
              workspace = "journal",
            }
          },
          -- ["core.integration.treesitter"] = {},
        },
      }
    end,
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false, -- Recommended
    -- ft = "markdown" -- If you decide to lazy-load anyway

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    }
  },
}
