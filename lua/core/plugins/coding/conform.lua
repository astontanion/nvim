return {
	"stevearc/conform.nvim",
	config = function()
		local config_status, config = pcall(require, "core.config.coding.conform")

		if not config_status then
			return
		end

		config.configure()
	end,
}
