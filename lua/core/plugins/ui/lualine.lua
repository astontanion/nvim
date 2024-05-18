return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local config_status, config = pcall(require, "core.config.ui.lualine")

		if not config_status then return end

		config.configure()
	end
}
