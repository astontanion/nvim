return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"folke/which-key.nvim"
	},
	config = function()
		local config_status, config = pcall(require, "core.config.ui.tree")

		if not config_status then return end

		config.configure()

		local mapping_status, mapping = pcall(require, "core.keybinding.tree")

		if not mapping_status then return end

		mapping.configure()
	end
}
