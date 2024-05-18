return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap"
	},
	config = function()
		local config_status, config = pcall(require, "core.config.lsp.dap-ui")

		if not config_status then return end

		config.configure()
	end
}
