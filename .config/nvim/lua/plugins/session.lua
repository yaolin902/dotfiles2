return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
      -- {"<leader>qs", "<cmd>lua require('persistence').load()<cr>" },
      -- {"<leader>qd", "<cmd>lua require('persistence').stop()<cr>"},
    },
  },
  {
    "ahmedkhalf/project.nvim",
    lazy = true,
    opts = {},
  }
}
