return {
	"catppuccin/nvim",
	name = "catppuccin",
	config = function()
		local status, catppuccin = pcall(require, "core.config.catppuccin")

		if not status then return end

		catppuccin.configure()

		local colors_scheme = "catppuccin-macchiato"

		local is_success, _ = pcall(vim.cmd, "colorscheme " .. colors_scheme)

		if not is_success then
			vim.notify("The colors scheme " .. colors_scheme .. " was not found!")
		end
	end
}
