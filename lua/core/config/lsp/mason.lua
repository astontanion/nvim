local M = {}

M.configure = function()
	local mason_status, mason = pcall(require, "mason")

	local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
	local mason_tool_status, mason_tool = pcall(require, "mason-tool-installer")

	if not (mason_status and mason_lspconfig_status and mason_tool_status)  then return end

	mason.setup({
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗"
			}
		}
	})

	mason_lspconfig.setup({
		ensure_installed = {
			"jdtls",
			"kotlin_language_server",
			"ltex",
			"lua_ls",
			"pyright",

			-- web
			"tsserver",
			"html",
			"cssls",
		}
	})

	mason_tool.setup({
		ensure_installed = {
			"stylua",
			"prettier",
			"isort"
		}
	})
end

return M
