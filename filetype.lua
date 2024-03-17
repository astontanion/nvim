local api = vim.api

local file_type_detect_group = api.nvim_create_augroup("filetypedetect", { clear = true})

api.nvim_create_autocmd(
	{ "BufRead", "BufNewFile" },
	{
		pattern = { "*.fga" },
		group = file_type_detect_group,
		command = ":set filetype=fga"
	}
)

