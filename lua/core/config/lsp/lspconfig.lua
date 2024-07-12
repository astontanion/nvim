local M = {}

M.configure = function()
	local lspconfig_status, lspconfig = pcall(require, "lspconfig")

	if not lspconfig_status then
		return
	end

	local on_attach = function(client, bufnr)
		local mapping_status, mapping = pcall(require, "core.keybinding.lspconfig")
		if not mapping_status then return end
		mapping.configure(bufnr)
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

	lspconfig["tailwindcss"].setup({
		filetypes = {
			"html",
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx"
		},
		cmd = { vim.fn.stdpath("data") .. "/mason/bin/tailwindcss-language-server", "--stdio" },
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
end

return M
