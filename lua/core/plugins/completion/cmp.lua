return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"L3MON4D3/LuaSnip",
	},
	event = "InsertEnter",
	config = function()
		local config_status, config = pcall(require, "core.config.completion.cmp")

		if not config_status then
			return
		end

		config.configure()
	end,
}
