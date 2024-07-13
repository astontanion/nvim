local M = {}

M.configure = function(bufnr)
	local which_key_status, which_key = pcall(require, "which-key")
	local has_builtin, builtin = pcall(require, "telescope.builtin")

	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	if not which_key_status and has_builtin then
		local bufopts = { noremap = true, silent = true, buffer = bufnr }

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
		vim.keymap.set("n", "<space>f", function()
			vim.lsp.buf.format({ async = true })
		end, bufopts)

		return
	end

	local lsp_keys = {
		{ mode = "n" },
		{ lhs = "<leader>c", group = "code" },
		{ lhs = "<leader>ca", rhs = vim.lsp.buf.code_action, desc = "actions" },
		{ lhs = "<leader>ci", rhs = builtin.lsp_implementations, desc = "Go to implementation" },
		{ lhs = "<leader>cd", rhs = vim.lsp.buf.declaration, desc = "Go to declaration" },
		{ lhs = "<leader>cf", rhs = builtin.lsp_definitions, desc = "Go to definition" },
		{ lhs = "<leader>cr", rhs = vim.lsp.buf.rename, desc = "Rename" },
		{ lhs = "<leader>ch", rhs = vim.lsp.buf.hover, desc = "Help" },
		{ lhs = "<leader>ct", rhs = builtin.lsp_type_definitions, desc = "Type definition" },
		{ lhs = "<leader>cu", rhs = builtin.lsp_references, desc = "Usage" },
		{
			lhs = "<leader>cp",
			rhs = function()
				local has_conform, conform = pcall(require, "conform")
				if not has_conform then
					return
				end
				conform.format({
					timeout = 1000,
					async = false,
					lsp_fallback = true,
				})
			end,
			desc = "Prettify",
		},
	}
	local diagonostic_keys = {
		{ mode = "n" },
		{ lhs = "<leader>ce", group = "errors" },
		{ lhs = "<leader>ceo", rhs = vim.diagnostic.open_float, desc = "Open" },
		{ lhs = "<leader>cel", rhs = vim.diagnostic.setloclist, desc = "List" },
		{ lhs = "<leader>cen", rhs = vim.diagnostic.goto_next, desc = "Next" },
		{ lhs = "<leader>cep", rhs = vim.diagnostic.goto_prev, desc = "Previous" },
	}

	which_key.add(lsp_keys)
	which_key.add(diagonostic_keys)
end

return M
