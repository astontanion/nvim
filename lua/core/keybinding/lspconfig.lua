local M = {}

M.configure = function(bufnr)
	local which_key_status, which_key = pcall(require, "which-key")
	local has_builtin, builtin = pcall(require, "telescope.builtin")

	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")


	if not which_key_status and has_builtin then
		local bufopts = { noremap=true, silent=true, buffer=bufnr }

		vim.keymap.set("n", "<leader>cd", vim.lsp.buf.declaration, bufopts)
		vim.keymap.set("n", "<leader>cf", vim.lsp.buf.definition, bufopts)
		vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, bufopts)
		vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, bufopts)

		vim.keymap.set("n", "<leader>ct", vim.lsp.buf.type_definition, bufopts)
		vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, bufopts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
		vim.keymap.set("n", "<leader>cu", vim.lsp.buf.references, bufopts)

		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, bufopts)
		vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format { async = true } end, bufopts)

		return
	end

	local lsp_keys = {
		name = "Code",
		a = { vim.lsp.buf.code_action, "actions" },
		i = { builtin.lsp_implementations, "Go to implementation" },
		d = { vim.lsp.buf.declaration, "Go to declaration" },
		f = { builtin.lsp_definitions, "Go to definition" },
		r = { vim.lsp.buf.rename, "Rename" },
		h = { vim.lsp.buf.hover, "Help" },
		t = { builtin.lsp_type_definitions, "Type definition" },
		u = { builtin.lsp_references, "References" },
	}

	local diagonostic_keys = {
		name = "error",
		o = { vim.diagnostic.open_float, "Open" },
		l = { vim.diagnostic.setloclist, "List" },
		n = { vim.diagnostic.goto_next, "Next" },
		p = { vim.diagnostic.goto_prev, "Previous"}
	}

	local mappings = {
		c = lsp_keys,
		ce = diagonostic_keys
	}

	local options = {
		mode = "n",
		prefix = "<leader>",
		silent = true,
		noremap = true
	}

	which_key.register(mappings, options)
end

return M
