local lspconfig_status, lspconfig = pcall(require, "lspconfig")

if not lspconfig_status then
	return
end

local on_attach = function(client, bufnr)
	local which_key_status, which_key = pcall(require, "which-key")

	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	if not which_key_status then
		local bufopts = { noremap=true, silent=true, buffer=bufnr }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, bufopts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
		vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
		vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format { async = true } end, bufopts)
	end

	local lsp_keys = {
		name = "Code",
		a = { vim.lsp.buf.code_action, "actions" },
		i = { vim.lsp.buf.implementation, "Go to implementation" },
		d = { vim.lsp.buf.declaration, "Go to declaration" },
		f = { vim.lsp.buf.definition, "Go to definition" },
		r = { vim.lsp.buf.rename, "Rename" },
		h = { vim.lsp.buf.hover, "Help" },
		t = { vim.lsp.buf.type_definition, "Type definition" },
		u = { vim.lsp.buf.references, "References" },
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

local lsp_flags = {
	debounce_text_changes = 150,
}

lspconfig.kotlin_language_server.setup({
    on_attach = on_attach,
	flags = lsp_flags
})

lspconfig["pyright"].setup({
	on_attach = on_attach,
	flags = lsp_flags
})

lspconfig["tsserver"].setup({
	on_attach = on_attach,
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx"
	},
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/typescript-language-server", "--stdio" },
	root_pattern = {
		"package.json",
		"tsconfig.json",
		"jsconfig.json",
		".git"
	},
	flags = lsp_flags
})

lspconfig.lua_ls.setup {
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				globals = {'vim'},
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
}

