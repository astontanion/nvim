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

		-- treesitter
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate"
		})

		-- color scheme 
		use("folke/tokyonight.nvim")
		use({ "catppuccin/nvim", as = "catppuccin" })

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

		-- notes/organisation 
		use("nvim-orgmode/orgmode")
		use("akinsho/org-bullets.nvim")

		use({
			"nvim-neorg/neorg",
			run = ":Neorg sync-parsers",
		})

		-- autocompletion
		use("/hrsh7th/nvim-cmp")
		use("/hrsh7th/cmp-buffer")
		use("/hrsh7th/cmp-path")

		-- lsp
		use("neovim/nvim-lspconfig")
		use("hrsh7th/cmp-nvim-lsp")
		use({
			"nvimdev/lspsaga.nvim",
			require = {
				"nvim-treesitter/nvim-treesitter",
				"nvim-tree/nvim-web-devicons"
			}
		})
		use("williamboman/mason.nvim")
		use("williamboman/mason-lspconfig.nvim")

		use("mfussenegger/nvim-jdtls")

		use("jose-elias-alvarez/typescript.nvim")

		use("onsails/lspkind.nvim")
		use({
			"rstacruz/vim-closer",
			ft = {"java", "kt", "ts", "js", "jsx", "lua"}
		})

		use("windwp/nvim-autopairs")
		use("windwp/nvim-ts-autotag")

		-- debugger
		use("mfussenegger/nvim-dap")
		use({
			"rcarriga/nvim-dap-ui",
			require = {
				"mfussenegger/nvim-dap"
			}
		})
		use("theHamsta/nvim-dap-virtual-text")

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
