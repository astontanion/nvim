local which_key_status, which_key = pcall(require, "which-key")

if not which_key_status then
	return
end

local window_keys = {

	{ mode = "n" },
	{ lhs = "<leader>w", group = "window" },
	{ lhs = "<leader>ws", rhs = vim.cmd.split, desc = "split horizontal" },
	{ lhs = "<leader>wv", rhs = vim.cmd.vsplit, desc = "split vertically" },
	{ lhs = "<leader>wn", rhs = vim.cmd.new, desc = "new" },
	{ lhs = "<leader>wc", rhs = vim.cmd.close, desc = "close" },
	{ lhs = "<leader>wb", rhs = "<c-w>=", desc = "balance" },

	{ lhs = "<leader>wK", rhs = "<c-w>K", desc = "Move up" },
	{ lhs = "<leader>wJ", rhs = "<c-w>J", desc = "Move down" },
	{ lhs = "<leader>wH", rhs = "<c-w>H", desc = "Move right" },
	{ lhs = "<leader>wL", rhs = "<c-w>L", desc = "Move left" },

	{ lhs = "<leader>wk", rhs = ":wincmd k<CR>", desc = "Cursor up" },
	{ lhs = "<leader>wj", rhs = ":wincmd j<CR>", desc = "Cursor down" },
	{ lhs = "<leader>wh", rhs = ":wincmd h<CR>", desc = "Cursor right" },
	{ lhs = "<leader>wl", rhs = ":wincmd l<CR>", desc = "Cursor left" },
}

local buffer_keys = {
	{ mode = "n" },
	{ lhs = "<leader>b", group = "buffer" },
	{ lhs = "<leader>bc", rhs = ":bd<CR>", desc = "Close" },
}

which_key.add(window_keys)
which_key.add(buffer_keys)
