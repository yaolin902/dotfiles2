local opt = vim.opt

opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.swapfile = false
opt.completeopt = "menuone,noinsert,noselect"

opt.number = true
opt.showmatch = true
opt.foldmethod = "marker"
opt.colorcolumn = "80"
opt.splitright = true
opt.splitbelow = true
opt.ignorecase = true
opt.smartcase = true
opt.termguicolors = true
opt.conceallevel = 0
opt.cmdheight = 1
opt.fileencoding = "utf-8"
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.signcolumn = "yes"
opt.showmode = false

opt.number = true
opt.relativenumber = true
opt.shortmess:append("c")
opt.whichwrap:append("<,>,[,],h,l")
opt.iskeyword:append("-")
opt.fillchars.eob = " "
opt.pumheight = 10
opt.undofile = true
opt.cursorline = true
opt.updatetime = 300
opt.timeout = true
opt.timeoutlen = 300

opt.background = "dark"

opt.list = true
opt.listchars:append("space:⋅")
opt.listchars:append("eol:↴")

opt.foldcolumn = '1'
opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.foldlevelstart = -1
opt.foldenable = true
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

