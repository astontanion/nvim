local M = {}

M.on_attach = function(client, bufnr)
	local mapping_status, mapping = pcall(require, "core.keybinding.lspconfig")
	if not mapping_status then
		return
	end
	mapping.configure(bufnr)
end

M.capabilities = function()
	local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	if cmp_nvim_lsp_status then
		capabilities = cmp_nvim_lsp.default_capabilities()
	end

	return capabilities
end

M.lsp_flags = function()
	local lsp_flags = {
		debounce_text_changes = 150,
	}

	return lsp_flags
end

M.configure = function()
	local lspconfig_status, lspconfig = pcall(require, "lspconfig")

	if not lspconfig_status then
		return
	end

	lspconfig.kotlin_language_server.setup({
		on_attach = M.on_attach,
		flags = M.lsp_flags(),
		capabilities = M.capabilities(),
	})

	lspconfig["pyright"].setup({
		on_attach = M.on_attach,
		flags = M.lsp_flags(),
		capabilities = M.capabilities(),
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
		capabilities = M.capabilities(),
	})

	lspconfig.lua_ls.setup({
		on_attach = M.on_attach,
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
		capabilities = M.capabilities(),
	})
end

return M
