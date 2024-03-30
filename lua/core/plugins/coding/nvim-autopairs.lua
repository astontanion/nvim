return {
	"windwp/nvim-autopairs",
	config = function()
		local config_status, config = pcall(require, "core.config.coding.autopairs")

		if not config_status then return end

		config.configure()
	end
}
