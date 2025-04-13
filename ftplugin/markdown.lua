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
