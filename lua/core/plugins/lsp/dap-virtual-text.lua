return {
	"theHamsta/nvim-dap-virtual-text",
	dependencies = {
		"mfussenegger/nvim-dap"
	},
	config = function()
		local config_status, config = pcall(require, "core.config.lsp.dap-virtual-text")

		if not config_status then return end

		config.configure()
	end
}
