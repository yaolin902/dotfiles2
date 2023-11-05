return {
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        vim.o.statusline = " "
      else
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      vim.o.laststatus = vim.g.lualine_laststatus
      return {
        options = {
          theme = "gruvbox",
          globalstatus = true,
          section_separators = '',
          component_separators = '',
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
        },
        sections = {
          lualine_a = { { 'mode', fmt = function(str) return str:sub(1, 1) end } },
          lualine_b = { "branch" },
          lualine_c = { "diagnostics", { "filename", path = 1, }, },
          lualine_x = { "diff" },
          lualine_y = { "location" },
          lualine_z = { "progress" },
        },
        extensions = { "nvim-tree", "lazy" },
      }
    end,
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    },
    opts = {
      options = {
        close_command = function(n) require("mini.bufremove").delete(n, false) end,
        right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        always_show_bufferline = true,
        offsets = {
          {
            highlight = "Directory",
            filetype = "NvimTree",
            text = "File Explorer",
            separator = true,
          },
        },
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = { char = "▏", },
      scope = { show_start = false, },
    }
  },

  { "karb94/neoscroll.nvim",       opts = {}, },
  { "nvim-focus/focus.nvim",       opts = {}, },
  { "kevinhwang91/nvim-hlslens",   opts = { calm_down = true, }, },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      require('ufo').setup({
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
          local newVirtText = {}
          local suffix = (" 󰁂 %d "):format(endLnum - lnum)
          local sufWidth = vim.fn.strdisplaywidth(suffix)
          local targetWidth = width - sufWidth
          local curWidth = 0
          for _, chunk in ipairs(virtText) do
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if targetWidth > curWidth + chunkWidth then
              table.insert(newVirtText, chunk)
            else
              chunkText = truncate(chunkText, targetWidth - curWidth)
              local hlGroup = chunk[2]
              table.insert(newVirtText, { chunkText, hlGroup })
              chunkWidth = vim.fn.strdisplaywidth(chunkText)
              if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
              end
              break
            end
            curWidth = curWidth + chunkWidth
          end
          table.insert(newVirtText, { suffix, "MoreMsg" })
          return newVirtText
        end,
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end
      })
    end,
  },
  {
    "luukvbaal/statuscol.nvim",
    opts = function()
      local builtin = require("statuscol.builtin")
      return {
        relculright = true,
        segments = {
          { text = { builtin.foldfunc },      click = "v:lua.ScFa" },
          { text = { "%s" },                  click = "v:lua.ScSa" },
          { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
        },
      }
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = function()
      local hl = vim.api.nvim_set_hl
      hl(0, "NoiceCmdlinePopupBorder", { fg = "#83A598", bg = "#282828"})
      hl(0, "NoiceCmdlineIcon", { fg = "#83A598", bg = "#282828"})
      hl(0, "NoiceCmdlineIconSearch", { fg = "#fabd2f", bg = "#282828"})
      hl(0, "NoiceCmdlinePopupBorderSearch", { fg = "#fabd2f", bg = "#282828"})
      return {
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          signature = {
            enabled = false,
          },
        },
        presets = {
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = false,
        },
      }
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      }
  },
}
