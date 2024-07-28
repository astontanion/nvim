local M = {}

M.configure = function()
	local lspconfig_status, lspconfig = pcall(require, "lspconfig")
	local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

	if not lspconfig_status then
		return
	end

	local on_attach = function(client, bufnr)
		local mapping_status, mapping = pcall(require, "core.keybinding.lspconfig")
		if not mapping_status then
			return
		end
		mapping.configure(bufnr)
	end

	local lsp_flags = {
		debounce_text_changes = 150,
	}

	local capabilities = vim.lsp.protocol.make_client_capabilities()

	if cmp_nvim_lsp_status then
		capabilities = cmp_nvim_lsp.default_capabilities()
	end

	lspconfig.kotlin_language_server.setup({
		on_attach = on_attach,
		flags = lsp_flags,
		capabilities = capabilities,
	})

	lspconfig["pyright"].setup({
		on_attach = on_attach,
		flags = lsp_flags,
		capabilities = capabilities,
	})

	lspconfig["tsserver"].setup({
		on_attach = on_attach,
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
		cmd = { vim.fn.stdpath("data") .. "/mason/bin/typescript-language-server", "--stdio" },
		root_pattern = {
			"package.json",
			"tsconfig.json",
			"jsconfig.json",
			".git",
		},
		flags = lsp_flags,
		capabilities = capabilities,
	})

	lspconfig["tailwindcss"].setup({
		filetypes = {
			"html",
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
		cmd = { vim.fn.stdpath("data") .. "/mason/bin/tailwindcss-language-server", "--stdio" },
		capabilities = capabilities,
	})

	lspconfig.lua_ls.setup({
		on_attach = on_attach,
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				},
				telemetry = {
					enable = false,
				},
			},
		},
		capabilities = capabilities,
	})
end

return M
