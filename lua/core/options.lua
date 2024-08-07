-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

vim.opt.backup = false
vim.opt.swapfile = false

vim.opt.autoindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.breakindent = true
vim.opt.linebreak = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoread = true
vim.opt.hidden = true
vim.opt.wrap = true
vim.opt.mouse = ""

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 999
vim.opt.updatetime = 50

vim.opt.foldmethod="expr"
vim.opt.foldexpr="nvim_treesitter#fodlexpr()"
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.opt.virtualedit = "block"
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
