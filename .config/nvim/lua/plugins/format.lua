return {
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(opts.sources, nls.builtins.formatting.black)
      table.insert(opts.sources, nls.builtins.formatting.prettier)
      table.insert(opts.sources, nls.builtins.formatting.clang_format)
      table.insert(opts.sources, nls.builtins.diagnostics.hadolint)
      table.insert(opts.sources, nls.builtins.diagnostics.mypy)
      table.insert(opts.sources, nls.builtins.diagnostics.ruff)
      table.insert(opts.sources, nls.builtins.diagnostics.flake8)
      table.insert(opts.sources, nls.builtins.diagnostics.pylyzer)
    end,
  },
  {
    "stevearc/conform.nvim",
    lazy = true,
    cmd = "ConformInfo",
    opts = {
      format = {
        timeout_ms = 3000,
        async = false,
        quiet = false,
      },
      formatters_by_ft = {
        ["python"] = { "black" },
        ["javascript"] = { "prettier" },
        ["javascriptreact"] = { "prettier" },
        ["typescript"] = { "prettier" },
        ["typescriptreact"] = { "prettier" },
        ["vue"] = { "prettier" },
        ["css"] = { "prettier" },
        ["scss"] = { "prettier" },
        ["less"] = { "prettier" },
        ["html"] = { "prettier" },
        ["json"] = { "prettier" },
        ["jsonc"] = { "prettier" },
        ["yaml"] = { "prettier" },
        ["markdown"] = { "prettier" },
        ["markdown.mdx"] = { "prettier" },
        ["graphql"] = { "prettier" },
        ["handlebars"] = { "prettier" },
      },
      formatters = {
        injected = { options = { ignore_errors = true } },
      }
    },
  },
}
