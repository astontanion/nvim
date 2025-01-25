local M = {}

M.configure = function()
	local lspconfig_status, lspconfig = pcall(require, "core.config.lsp.lspconfig")

	local tools_status, tools = pcall(require, "typescript-tools")

	if not (tools_status and lspconfig_status) then
		return
	end

	tools.setup({
		on_attach = lspconfig.on_attach,
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
		flags = lspconfig.lsp_flags(),
		capabilities = lspconfig.capabilities(),
	})
end

return M
