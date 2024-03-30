return {
	"mfussenegger/nvim-dap",
	config = function()
		local config_status, config = pcall(require, "core.config.lsp.dap")

		if not config_status then return end

		config.configure()

		local mapping_status, mapping = pcall(require, "core.keybinding.dap")

		if not mapping_status then return end

		mapping.configure()
	end
}
