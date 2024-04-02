return {
	"nvim-neorg/neorg",
    dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-neotest/nvim-nio",
		"nvim-neorg/lua-utils.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter"
	},
    lazy = false,
    version = "7.0.0",
    config = function()
		local config_status, config = pcall(require, "core.config.notes.neorg")
		if not config_status then return end;
		config.configure()
	end
}
