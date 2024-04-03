local M = {}

M.configure = function()
	local dressing_status, dressing = pcall(require, "dressing")
	if not dressing_status then return end

	dressing.setup({
		input = {
			title_pos = "center",
		}
	})
end

return M
