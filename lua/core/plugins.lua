local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "core.plugins.theme" },
	{ import = "core.plugins.ui" },
	{ import = "core.plugins.completion" },
	{ import = "core.plugins.coding" },
	{ import = "core.plugins.lsp" },
	{ import = "core.plugins.notes" },
})
