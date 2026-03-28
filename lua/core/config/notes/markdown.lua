local M = {}

M.configure = function()
	local markdown_status, markdown = pcall(require, "render-markdown")

	if not markdown_status then
		return
	end

	markdown.setup({
		render_modes = { "n", "c", "t", "i" },
		heading = {
			backgrounds = {},
			position = "inline",
		},
		indent = {
			enabled = true,
		},
		code = {
			style = "language",
			left_pad = 2,
			right_pad = 4,
		},
		checkbox = {
			enabled = true,
			checked = {
				icon = "- (󰄬)",
			},
			unchecked = {
				icon = "- (×)",
			},
			custom = {
				hold = {
					raw = "[=]",
					rendered = "- ()",
					highlight = "RenderMarkdownInfo",
					scope_highlight = nil,
				},
				urgent = {
					raw = "[!]",
					rendered = "- (⚠)",
					highlight = "RenderMarkdownError",
					scope_highlight = nil,
				},
				todo = {
					raw = "[-]",
					rendered = "- (󰥔)",
					highlight = "RenderMarkdownTodo",
					scope_highlight = nil,
				},
				waiting = {
					raw = "[?]",
					rendered = "- ()",
					highlight = "RenderMarkdownWarn",
					scope_highlight = nil,
				},
				cancelled = {
					raw = "[_]",
					rendered = "- ()",
					highlight = "RenderMarkdownUnchecked",
					scope_highlight = nil,
				},
				recurring = {
					raw = "[+]",
					rendered = "- (↺)",
					highlight = "RenderMarkdownHint",
					scope_highlight = nil,
				},
			},
		},
	})
end

return M
