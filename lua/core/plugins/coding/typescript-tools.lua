return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	config = function()
		local config_status, config = pcall(require, "core.config.coding.typescript-tools")

		if not config_status then
			return
		end

		config.configure()
	end,
}
