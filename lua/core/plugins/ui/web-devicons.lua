return {
	"nvim-tree/nvim-web-devicons",
	config = function()
		local config_status, config = pcall(require, "core.config.nivm.ui.web-devicons")

		if not config_status then return end

		config.configure()
	end
}
