return {
	"/hrsh7th/nvim-cmp",
	config = function()
		local config_status, config = pcall(require, "core.config.completion.cmp")

		if not config_status then return end

		config.configure()
	end
}
