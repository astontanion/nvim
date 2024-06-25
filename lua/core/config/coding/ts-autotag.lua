local M = {}

M.configure = function()
	local has_autotag, autotag = pcall(require, "nvim-ts-autotag")

	if not has_autotag then return end

	autotag.setup({})
end

return M


