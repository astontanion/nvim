local M = {}

M.configure = function()
	local has_autopairs, autopairs = pcall(require, "nvim-autopairs")

	if not has_autopairs then return end

	autopairs.setup({
	  disable_filetype = { "TelescopePrompt" , "vim" },
	})
end

return M
