local M = {}

M.configure = function()
	local has_conform, conform = pcall(require, "conform")

	if not has_conform then return end

	conform.setup({
		formatters_by_ft = {
			lua = { "stylua" },
			html = { "prettier" },
			css = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			python = { "isort" },
		},

		format_on_save = {
			timeout = 1000,
			async = false,
			lsp_fallback = true
		}
	})
end

return M
