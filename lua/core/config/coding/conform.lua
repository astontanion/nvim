local M = {}

M.configure = function()
	local has_conform, conform = pcall(require, "conform")

	if not has_conform then
		return
	end

	conform.setup({
		formatters_by_ft = {
			lua = { "stylua" },
			html = { "prettier" },
			css = { "prettier" },
			json = { "prettier" },
			yaml = { "yq" },
			markdown = { "prettier" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			python = { "isort" },
		},

		formatters = {
			prettier = {
				prepend_args = { "--tab-width", "4" },
			},
		},

		format_on_save = {
			timeout = 1000,
			async = false,
			lsp_fallback = false,
		},
	})
end

return M
