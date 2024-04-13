return {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    optional = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = { -- Manages Neorg workspaces
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
    'lukas-reineke/headlines.nvim',
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
  },
}
