vim.g.mapleader = "'"
vim.g.maplocalleader = "'"

local map = vim.keymap.set

map("n", "j", "v:count ? 'j' : 'gj'", { silent = true, expr = true })
map("n", "k", "v:count ? 'k' : 'gk'", { silent = true, expr = true })
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
