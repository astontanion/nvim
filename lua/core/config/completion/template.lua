local M = {}

M.configure = function()
	local template_status, template = pcall(require, "template")

	if not template_status then
		return
	end

	local my_name = os.getenv("MY_NAME")
	local my_email = os.getenv("MY_EMAIL")
	local template_dir = os.getenv("MY_NOTE_TEMPLATE")

	template.setup({
		temp_dir = template_dir,
		author = my_name,
		email = my_email,
	})

	M.register_custom_templates(template)
end

M.register_custom_templates = function(template)
	template.register("{{_id_}}", M.generage_id)
	template.register("{{_title_}}", M.generate_title)
end

M.generage_id = function()
	return string.format("%x", os.time())
end

M.generate_title = function()
	local file_name = vim.fn.expand("%:t:r")
	file_name = string.gsub(file_name, "-", " ")
	return file_name:sub(1, 1):upper() .. file_name:sub(2):lower()
end

return M
