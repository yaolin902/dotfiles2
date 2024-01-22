return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })
      end)

      return {
        ensure_installed = { 'clangd', },
        handlers = {
          lsp_zero.default_setup,
        },
      }
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>",      desc = "Code Action" },
      { "<leader>ld", "<cmd>Lspsaga peek_definition<CR>",            desc = "Peek Def" },
      { "<leader>lf", "<cmd>lua vim.lsp.buf.format{async=true}<cr>", desc = "Format" },
      { "<leader>lo", "<cmd>Lspsaga outline<CR>",                    desc = "Outline" },
      { "<leader>li", "<cmd>LspInfo<CR>",                            desc = "Info" },
      { "<leader>lm", "<cmd>Mason<CR>",                              desc = "Mason" },
      { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>",         desc = "Code Lens" },
      { "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>",     desc = "Next Diagnostic" },
      { "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>",     desc = "Prev Diagnostic" },
      {
        "<leader>lh",
        function()
          vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
        end,
        desc = "Toggle Hints"
      },
    },
    dependencies = {
      -- { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      -- { "folke/neodev.nvim", opts = {} },
      { "nvimdev/lspsaga.nvim", opts = { ui = { code_action = "", border = "none", }, }, },
      {
        "folke/trouble.nvim",
        keys = {
          { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document Diagnostics (Trouble)" },
          { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
          { "<leader>xL", "<cmd>TroubleToggle loclist<cr>",               desc = "Location List (Trouble)" },
          { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>",              desc = "Quickfix List (Trouble)" },
        }
      },
      -- { "lvimuser/lsp-inlayhints.nvim", branch = "anticonceal",  opts = {},},
    },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
      },
      inlay_hints = {
        enabled = true,
      },
      capabilities = {},
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP Server Settings
      servers = {
        lua_ls = {
          single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
              hint = {
                enable = true,
                arrayIndex = "Enable",
                setType = true,
              },
            },
          },
        },
        clangd = {
          keys = {
            {
              "<leader>cR",
              "<cmd>ClangdSwitchSourceHeader<cr>",
              desc =
              "Switch Source/Header (C/C++)"
            },
          },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "Makefile",
              "configure.ac",
              "configure.in",
              "config.h.in",
              "meson.build",
              "meson_options.txt",
              "build.ninja"
            )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
              fname
            ) or require("lspconfig.util").find_git_ancestor(fname)
          end,
          capabilities = {
            offsetEncoding = { "utf-16" },
          },
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },
        pyright = {
          analysis = {
            typeCheckingMode = "basic",
          }
        },
        ruff_lsp = {
          autostart = false,
        },
        pylyzer = {
          autostart = false,
          cmd = { '/home/yao/.local/share/nvim/mason/bin/pylyzer', '--server' },
          filetypes = { 'python' },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "pyproject.toml",
              "setup.py",
              "setup.cfg",
              "requirements.txt",
              "Pipfile"
            )(fname) or require("lspconfig.util").find_git_ancestor(
              fname
            ) or require("lspconfig.util").path.dirname(fname)
          end,
          settings = {
            python = {
              checkOnType = false,
              diagnostics = true,
              inlayHints = true,
              smartCompletion = true,
            }
          }
        },
      },
      setup = {},
    },
    config = function(_, opts)
      local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "󰌵" },
        { name = "DiagnosticSignInfo", text = "" },
      }

      local hl = vim.api.nvim_set_hl
      hl(0, "LspInlayHint", { fg = "#d5c4a1", bg = "#504945" })

      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
      end

      -- This is where all the LSP shenanigans will live
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()


      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        require "lsp_signature".on_attach({
          hint_enable = false,
          handler_opts = {
            border = "none",
          },
        }, bufnr)

        -- if client.name == "clangd" then
        --   require("clangd_extensions.inlay_hints").setup_autocmd()
        --   require("clangd_extensions.inlay_hints").set_inlay_hints()
        -- end

        -- if client.server_capabilities.inlayHintProvider then
        --   vim.lsp.inlay_hint(bufnr, false)
        -- end

        lsp_zero.default_keymaps({ buffer = bufnr })
      end)

      -- (Optional) Configure lua language server for neovim
      local lua_opts = lsp_zero.nvim_lua_ls(opts.servers.lua_ls)
      require('lspconfig').lua_ls.setup(lua_opts)
      require('lspconfig').pylyzer.setup(opts.servers.pylyzer)

      -- custom lsp
      local lspconfig = require 'lspconfig'
      local configs = require 'lspconfig.configs'

      if not configs.secret_lsp then
        configs.secret_lsp = {
          default_config = {
            cmd = { 'delance-langserver', '--stdio' },
            root_dir = function(fname)
              return require("lspconfig.util").root_pattern(
                "pyproject.toml",
                "setup.py",
                "setup.cfg",
                "requirements.txt",
                "Pipfile"
              )(fname) or require("lspconfig.util").find_git_ancestor(
                fname
              ) or require("lspconfig.util").path.dirname(fname)
            end,
            filetypes = { 'python' },
            single_file_support = true,
            settings = {
              python = {
                pythonPath = "/usr/bin/python3",
                analysis = {
                  inlayHints = {
                    variableTypes = true,
                    functionReturnTypes = true,
                    callArgumentNames = true,
                  },
                },
              },
            },
          },
        }
      end
      lspconfig.secret_lsp.setup {}
    end,
  },


  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "prettier",
        "black",
        "hadolint",
        "mypy",
        "ruff",
        "pyright",
        "clangd",
        "clang-format",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },

  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts) require 'lsp_signature'.setup(opts) end
  },

  {
    "RRethy/vim-illuminate",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
  },
}
