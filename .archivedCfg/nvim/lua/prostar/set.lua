vim.cmd("set mouse=")
vim.cmd("set number")
vim.cmd("set relativenumber")

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.undofile = true

vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.hlsearch = false
vim.opt.incsearch = true
