local M = {}

M.configure = function()
	local icons_status, icons = pcall(require, "nvim-web-devicons")

	if not icons_status then
		return
	end

	icons.setup({
		override = {},
		default = true
	})
end

return M
