local M = {}

M.configure = function()
	local which_key_status, which_key = pcall(require, "which-key")
	local jdtls_status, jdtls = pcall(require, "jdtls")

	if not which_key_status and jdtls_status then return end

	local jdtls_keys = {
		name = "Java",
		i = { jdtls.organize_imports, "Organize imports" },
		v = { jdtls.extract_variable, "Extract variable" },
		c = { jdtls.extract_constant, "Extract constant" },
		m = { jdtls.extract_method, "Extract method" }
	}

	local test_keys = {
		name = "Test",
		a = { jdtls.test_class, "Test all" },
		c = {
			function()
				local file_path = vim.fn.expand("%:p")
				local test_path = string.gsub(file_path, "(%w+)%.java", "%1Test.java")
				test_path = string.gsub(test_path, "(/src/main/)", "/src/test/")
				vim.cmd(":e " .. test_path)
			end,
			"Create"
		},
		m = { jdtls.test_nearest_method, "Test method" }
	}

	local mappings = {
		cj = jdtls_keys,
		ct = test_keys
	}

	local options = {
		mode = "n",
		prefix = "<leader>",
		silent = true,
		noremap = true
	}

	which_key.register(mappings, options)
end

return M
