local M = {}

M.configure = function()
	local twilight_status, twilight = pcall(require, "twilight")

	if not twilight_status then
		return
	end

	print("working")

	twilight.setup({
		dimming = {
			alpha = 0.25,
			color = { "Normal", "#ffffff" },
			term_bg = "#000000",
			inactive = false,
		},
		context = 10,
		treesitter = true,
		expand = {
			"function",
			"method",
			"table",
			"if_statement",
		},
		exclude = {},
	})
end

return M
