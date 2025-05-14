local get_file_id = function()
	local match_line_number = vim.fn.search("^id:", "n")
	local match_line = vim.fn.getline(match_line_number)
	local id = vim.fn.matchlist(match_line, "^id:\\s*\\([0-9a-fA-F]*\\)")[2]

	if id == nil then
		id = string.format("%x", os.time())
	end

	return id
end

local function regexEscape(str)
	return str:gsub("[%(%)%.%%%+%-%*%?%[%^%$%]]", "%%%1")
end

string.replace = function(str, this, that)
	return str:gsub(regexEscape(this), that:gsub("%%", "%%%%")) -- only % needs to be escaped for 'that'
end

vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("zettle", { clear = true }),
	pattern = { "*/notes/*.md" },
	callback = function(args)
		local bufnr = args.buf
		local file_name = vim.fn.expand("%:t")
		local file = args.match

		local id = get_file_id()

		-- check if the file already contains the id
		local has_id = vim.fn.match(file_name, "^[0-9a-fA-F]\\{8,\\}-") ~= -1

		if has_id then
			return
		end

		local new_file_name = id .. "-" .. file_name
		local new_file_path = vim.fn.substitute(file, file_name, new_file_name, "g")

		vim.api.nvim_buf_set_name(bufnr, new_file_path)

		vim.api.nvim_buf_call(bufnr, function()
			vim.cmd("silent! write!")
			vim.cmd("edit")
		end)

		local new_file_exists = vim.fn.findfile(new_file_path) ~= ""

		if new_file_exists then
			vim.fs.rm(file)
		end
	end,
})

local which_key_status, which_key = pcall(require, "which-key")

if not which_key_status then
	return
end

local zettel_dir = os.getenv("NOTES_ZETTEL_DIR")

local note_keys = {
	{ lhs = "<leader>n", group = "Notes" },
	{
		lhs = "<leader>nk",
		rhs = ":!mv '%:p' " .. zettel_dir .. "<cr>:bd<cr>",
		desc = "Keep",
	},
	{
		lhs = "<leader>nd",
		rhs = ":!rm '%:p'<cr>:bd<cr>",
		desc = "Delete",
	},
}

which_key.add(note_keys)
