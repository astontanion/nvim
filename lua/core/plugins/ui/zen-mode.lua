return {
	"folke/zen-mode.nvim",
	config = function()
		local config_status, config = pcall(require, "core.config.ui.zen-mode")

		if not config_status then
			return
		end

		config.configure()
	end,
}
