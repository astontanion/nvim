local which_key_status, which_key = pcall(require, "which-key")

if not which_key_status then
	return
end

local window_keys = {
	name = "window",
	s = { vim.cmd.split, "split horizontal" },
	v = { vim.cmd.vsplit, "split vertically"},
	n = { vim.cmd.new, "new"},
	c = { vim.cmd.close, "close"},
	b = { "<c-w>=", "balance"},

	K = { "<c-w>K", "Move up"},
	J = { "<c-w>J", "Move down"},
	H = { "<c-w>H", "Move right"},
	L = { "<c-w>L", "Move left"},

	k = { ":wincmd k<CR>", "Cursor up"},
	j = { ":wincmd j<CR>", "Cursor down"},
	h = { ":wincmd h<CR>", "Cursor right"},
	l = { ":wincmd l<CR>", "Cursor left"}
}

local buffer_keys = {
    name = "Buffer",
    c = {":bd<CR>", "Close" }
}

local mappings = {
	w = window_keys,
    b = buffer_keys
}

local options = {
	mode = "n",
	prefix = "<leader>",
	silent = true,
	noremap = true
}

which_key.register(mappings, options)
