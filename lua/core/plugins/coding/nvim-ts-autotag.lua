return {
	"windwp/nvim-ts-autotag",
	config = function()
		local config_status, config = pcall(require, "core.config.coding.ts-autotag")

		if not config_status then return end

		config.configure()
	end
}
