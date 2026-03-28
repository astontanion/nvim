return {
	"glepnir/template.nvim",
	config = function()
		local config_status, config = pcall(require, "core.config.completion.template")

		if not config_status then
			return
		end

		config.configure()
	end,
}
