return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim"
	},
	config = function()
		local config_status, config = pcall(require, "core.config.lsp.mason")

		if not config_status then return end

		config.configure()
	end
}
