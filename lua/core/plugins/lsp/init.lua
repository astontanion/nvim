return {
	"hrsh7th/cmp-nvim-lsp",
	{
		"mfussenegger/nvim-jdtls",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
	},
	{
		"nvimdev/lspsaga.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
}
