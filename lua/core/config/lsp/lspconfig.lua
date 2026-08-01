local M = {}

M.on_attach = function(_, bufnr)
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
		debounce_text_changes = 80,
	}

	return lsp_flags
end

M.configure = function()
	local jdtls = require("core.config.lsp.server.jdtls")

	vim.lsp.config("jdtls", {
		on_attach = jdtls.on_attach,
		flags = M.lsp_flags(),
		capabilities = jdtls.capabilities(),
		init_options = jdtls.init_options(),
		settings = jdtls.settings(),
		cmd = jdtls.cmd(),
		root_dir = jdtls.get_root_dir(),
	})

	vim.lsp.enable("jdtls")

	vim.lsp.config("kotlin_lsp", {
		filetypes = { "kotlin", "kt", "kts" },
		on_attach = M.on_attach,
		flags = M.lsp_flags(),
		capabilities = M.capabilities(),
	})

	vim.lsp.enable("kotlin_lsp")

	vim.lsp.config("pyright", {
		on_attach = M.on_attach,
		flags = M.lsp_flags(),
		capabilities = M.capabilities(),
	})

	vim.lsp.enable("pyright")

	vim.lsp.config("tailwindcss", {
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

	vim.lsp.enable("tailwindcss")

	vim.lsp.config("lua_ls", {
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

	vim.lsp.enable("lua_ls")

	vim.lsp.config("marksman", {
		on_attach = M.on_attach,
		flags = M.lsp_flags(),
		capabilities = M.capabilities(),
	})

	vim.lsp.enable("marksman")
end

return M
