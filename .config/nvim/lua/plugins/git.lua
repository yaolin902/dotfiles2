return {
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local hl = vim.api.nvim_set_hl

        hl(0, "GitSignsAdd", { fg = "#b8bb26", bg = "#3c3836" })
        hl(0, "GitSignsChange", { fg = "#8ec07c", bg = "#3c3836" })
        hl(0, "GitSignsDelete", { fg = "#fb4934", bg = "#3c3836" })
        hl(0, "GitSignsChangeDelete", { fg = "#fb4934", bg = "#3c3836" })

        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },

  },
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff View" },
    },
  },
  {
    "kdheepak/lazygit.nvim",
    init = function()
      vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
    end
  },
  {
    "NeogitOrg/neogit",
    lazy = true,
    cmd = "Neogit",
    keys = {
      { "<leader>gn", "<cmd>Neogit<cr>", desc = "Neogit" },
    },
    opts = {
      disable_commit_confirmation = true,
      integrations = {
        diffview = true,
      },
    },
  },
  {
    "akinsho/git-conflict.nvim",
    opts = {
      default_mappings = false,
      disable_diagnostics = true,
    },
    keys = {
      { "<leader>gco", ":GitConflictChooseOurs<cr>",   desc = "Conflict Choose Ours" },
      { "<leader>gct", ":GitConflictChooseTheirs<cr>", desc = "Conflict Choose Theirs" },
      { "<leader>gcb", ":GitConflictChooseBoth<cr>",   desc = "Conflict Choose Both" },
      { "<leader>gc0", ":GitConflictChooseNone<cr>",   desc = "Conflict Choose None" },
      { "]x",          ":GitConflictNextConflict<cr>" },
      { "[x",          ":GitConflictPrevConflict<cr>" },
    },
  },
  {
    "f-person/git-blame.nvim",
    init = function()
      require("gitblame").setup({
        enabled = false,
      })
      vim.g.gitblame_display_virtual_text = 1
    end,
  },
}
