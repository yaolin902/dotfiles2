local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('BufferClear', { clear = true })

-- Highlight on yank
autocmd('TextYankPost', {
  group = 'BufferClear',
  callback = function()
    vim.highlight.on_yank({ higroup = 'Visual', timeout = '200' })
  end
})


-- Remove whitespace on save
autocmd('BufWritePre', {
  pattern = '',
  command = ":%s/\\s\\+$//e"
})


-- Start Git messages in insert mode
autocmd('FileType', {
  group    = 'BufferClear',
  pattern  = { 'gitcommit', 'gitrebase', },
  command  = 'startinsert | 1'
})

-- Go to last location on buffer open
autocmd('BufReadPost',  {
  group    = 'BufferClear',
  pattern  = '*',
  callback = function()
     local ft = vim.opt_local.filetype:get()
        -- don't apply to git messages
        if (ft:match('commit') or ft:match('rebase')) then
            return
        end
        -- get position of last saved edit
        local markpos = vim.api.nvim_buf_get_mark(0,'"')
        local line = markpos[1]
        local col = markpos[2]
        -- if in range, go there
        if (line > 1) and (line <= vim.api.nvim_buf_line_count(0)) then
            vim.api.nvim_win_set_cursor(0,{line,col})
        end
  end
})


-- Enter insert mode when switching to terminal
autocmd('TermOpen', {
  command = 'setlocal listchars= nonumber norelativenumber nocursorline',
})

autocmd('TermOpen', {
  pattern = '',
  command = 'startinsert'
})


-- Close terminal buffer on process exit
autocmd('BufLeave', {
  pattern = 'term://*',
  command = 'stopinsert'
})


-- Close some filetype with <q>
autocmd("FileType", {
  group = 'BufferClear',
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})


-- Wrap and spell check for certain file
autocmd("FileType", {
  group = 'BufferClear',
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})


-- Disable focus for nvim-tree
local ignore_filetypes = { 'nvim-tree', 'NvimTree', "undotree" }
local ignore_buftypes = { 'nofile', 'prompt', 'popup', "undotree" }

autocmd('WinEnter', {
    group = 'BufferClear',
    callback = function(_)
        if vim.tbl_contains(ignore_buftypes, vim.bo.buftype)
        then
            vim.w.focus_disable = true
        else
            vim.w.focus_disable = false
        end
    end,
})

autocmd('FileType', {
    group = 'BufferClear',
    callback = function(_)
        if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
            vim.b.focus_disable = true
        else
            vim.b.focus_disable = false
        end
    end,
})
