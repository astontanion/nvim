return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config_status, config = pcall(require, "core.config.treesitter")

		if not config_status then return end

		config.configure()
	end
}
