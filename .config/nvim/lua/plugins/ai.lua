return {
  {
    'tzachar/cmp-tabnine',
    optional = true,
    build = './install.sh',
    dependencies = 'hrsh7th/nvim-cmp',
  },
  {
    "Exafunction/codeium.nvim",
    -- optional = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    opts = {},
    -- cond = vim.fn.system('ping -c 1 google.com > /dev/null 2>&1') == 0,
  },
  {
    "David-Kunz/gen.nvim",
    keys = {
      { "<leader>]", ":Gen<cr>", mode = { "v", "n" } },
    },
    opts = {
      model = "codellama:7b",
      display_mode = "split",
      show_prompt = true,
      show_model = true,
    },
  },
  -- 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
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    },
    keys = {
      { "<leader>cc", "<cmd>ChatGPT<CR>",                              "ChatGPT" },
      { "<leader>ce", "<cmd>ChatGPTEditWithInstruction<CR>",           "Edit with instruction",     mode = { "n", "v" } },
      { "<leader>cg", "<cmd>ChatGPTRun grammar_correction<CR>",        "Grammar Correction",        mode = { "n", "v" } },
      { "<leader>ct", "<cmd>ChatGPTRun translate<CR>",                 "Translate",                 mode = { "n", "v" } },
      { "<leader>ck", "<cmd>ChatGPTRun keywords<CR>",                  "Keywords",                  mode = { "n", "v" } },
      { "<leader>cd", "<cmd>ChatGPTRun docstring<CR>",                 "Docstring",                 mode = { "n", "v" } },
      { "<leader>ca", "<cmd>ChatGPTRun add_tests<CR>",                 "Add Tests",                 mode = { "n", "v" } },
      { "<leader>co", "<cmd>ChatGPTRun optimize_code<CR>",             "Optimize Code",             mode = { "n", "v" } },
      { "<leader>cs", "<cmd>ChatGPTRun summarize<CR>",                 "Summarize",                 mode = { "n", "v" } },
      { "<leader>cf", "<cmd>ChatGPTRun fix_bugs<CR>",                  "Fix Bugs",                  mode = { "n", "v" } },
      { "<leader>cx", "<cmd>ChatGPTRun explain_code<CR>",              "Explain Code",              mode = { "n", "v" } },
      { "<leader>cr", "<cmd>ChatGPTRun roxygen_edit<CR>",              "Roxygen Edit",              mode = { "n", "v" } },
      { "<leader>cl", "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis", mode = { "n", "v" } },
    },
  },
}
