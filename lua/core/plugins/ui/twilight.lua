return {
	"folke/twilight.nvim",
	config = function()
		local config_status, config = pcall(require, "core.config.ui.twilight")

		if not config_status then
			return
		end

		config.configure()
	end,
}
