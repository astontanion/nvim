return {
	"L3MON4D3/LuaSnip",
	version = "v2.3.0",
	config = function()
		local config_status, config = pcall(require, "core.config.completion.luasnip")

		if not config_status then
			return
		end

		config.configure()
	end,
}
