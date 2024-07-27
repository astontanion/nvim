local M = {}

M.configure = function()
	local which_key_status, which_key = pcall(require, "which-key")
	local jdtls_status, jdtls = pcall(require, "jdtls")

	if not which_key_status and jdtls_status then
		return
	end

	local jdtls_keys = {
		{ mode = "n" },
		{ lhs = "<leader>cj", group = "java" },
		{ lhs = "<leader>cji", rhs = jdtls.organize_imports, desc = "Organize imports" },
		{ lhs = "<leader>cjv", rhs = jdtls.extract_variable, desc = "Extract variable" },
		{ lhs = "<leader>cjc", rhs = jdtls.extract_constant, desc = "Extract constant" },
		{ lhs = "<leader>cjm", rhs = jdtls.extract_method, desc = "Extract method" },
	}

	local test_keys = {
		{ mode = "n" },
		{ lhs = "<leader>ct", group = "test" },
		{ lhs = "<leader>cta", rhs = jdtls.test_class, desc = "Test all" },
		{
			lhs = "<leader>ctc",
			rhs = function()
				local file_path = vim.fn.expand("%:p")
				local test_path = string.gsub(file_path, "(%w+)%.java", "%1Test.java")
				test_path = string.gsub(test_path, "(/src/main/)", "/src/test/")
				vim.cmd(":e " .. test_path)
			end,
			desc = "Create",
		},
		{ lhs = "<leader>ctm", rhs = jdtls.test_nearest_method, desc = "Test method" },
	}

	which_key.add(jdtls_keys)
	which_key.add(test_keys)
end

return M
