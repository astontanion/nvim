local mason_status, mason = pcall(require, "mason")

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")

if not mason_status then return end
if not mason_lspconfig_status then return end

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
		"tsserver",
		"html",
		"cssls",
		"jdtls",
		"kotlin_language_server",
		"ltex",
		"lua_ls",
		"pyright",
	}
})
