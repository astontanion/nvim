local ensure_packer = function()
	local fn = vim.fn

	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end

	return false
end

local packer_bootstrap = ensure_packer()

local is_success, packer = pcall(require, "packer")

if not is_success then
	return
end

return packer.startup(
	function(use)
		use("wbthomason/packer.nvim")

		-- color scheme 
		use("folke/tokyonight.nvim")

		-- lua line
		use({
			"nvim-lualine/lualine.nvim",
			requires = { "nvim-tree/nvim-web-devicons", opt = true }
		})

		-- nvim tree
		use("nvim-tree/nvim-web-devicons")
		use({
			'nvim-tree/nvim-tree.lua',
	  		tag = 'nightly'
		})

		-- telescope
		use({
			"nvim-telescope/telescope.nvim",
			tag = "0.1.2",
			requires = { { "nvim-lua/plenary.nvim" } }
		})
		use("nvim-telescope/telescope-ui-select.nvim")
		use({
			"nvim-telescope/telescope-file-browser.nvim",
			requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
		})

		-- org mode
		use("nvim-orgmode/orgmode")
		use("akinsho/org-bullets.nvim")

		-- autocompletion
		use("/hrsh7th/nvim-cmp")
		use("/hrsh7th/cmp-buffer")
		use("/hrsh7th/cmp-path")

		-- treesitter
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate"
		})

		-- lsp
		use("neovim/nvim-lspconfig")
		use("hrsh7th/cmp-nvim-lsp")
		use({
			"glepnir/lspsaga.nvim",
			branch = "main"
		})
		use("williamboman/mason.nvim")
		use("williamboman/mason-lspconfig.nvim")

		use("mfussenegger/nvim-jdtls")

		use("onsails/lspkind.nvim")
		use({
			"rstacruz/vim-closer",
			ft = {"java", "kt", "ts", "js", "jsx", "lua"}
		})

		-- which key
		use({
			"folke/which-key.nvim",
			config = function()
				vim.opt.timeout = true
				vim.opt.timeoutlen = 300
			end
		})

		if packer_bootstrap then
			require("packer").sync()
		end
	end
)
