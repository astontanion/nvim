local M = {}

M.is_os_linux = vim.fn.has("linux") > 0
M.is_os_mack = vim.fn.has("mac") > 0

M.get_config_type = function()
	if M.is_os_linux then
		return "/config_linux"
	end
	if M.is_os_mac then
		return "/config_mac"
	end
	return "/config_win"
end

M.runtimes = function()
	if M.is_os_linux then
		return {
			{
				name = "JavaSE-21",
				path = "/usr/lib/jvm/java-21-openjdk/",
			},
			{
				name = "JavaSE-17",
				path = "/usr/lib/jvm/java-17-openjdk/",
			},
		}
	end

	if M.is_os_mac then
		return {
			{
				name = "JavaSE-21",
				path = "/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home",
			},
		}
	end

	return {}
end

M.get_root_dir = function()
	local setup_status, setup = pcall(require, "jdtls.setup")

	if not setup_status then
		return
	end

	local root_markers = { "gradlew", "mvnw", ".git" }
	return setup.find_root(root_markers)
end

M.cmd = function()
	local home = os.getenv("HOME")
	local jdtls_dir = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
	local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(M.get_root_dir(), ":p:h:t")
	return {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx4g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		vim.fn.glob(jdtls_dir .. "/plugins/org.eclipse.equinox.launcher_*.jar", 1),
		"-configuration",
		jdtls_dir .. M.get_config_type(),
		"-data",
		workspace_folder,
	}
end

M.capabilities = function()
	local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp-nvim-lsp")

	local capabilities = vim.lsp.protocol.make_client_capabilities()

	if cmp_nvim_lsp_status then
		capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
	end

	return capabilities
end

M.on_attach = function(_, bufnr)
	local jdtls_status, jdtls = pcall(require, "jdtls")

	if not jdtls_status then
		return
	end

	local mapping_status, mapping = pcall(require, "core.keybinding.lspconfig")

	if not mapping_status then
		return
	end

	mapping.configure(bufnr)

	local java_mapping_status, java_mapping = pcall(require, "core.keybinding.java")

	if not java_mapping_status then
		return
	end

	java_mapping.configure()

	require("jdtls.dap").setup_dap()
end

M.init_options = function()
	local dap_install_dir = vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter/extension/server"
	local java_test_dir = vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server"

	local bundles = {
		vim.fn.glob(dap_install_dir .. "/com.microsoft.java.debug.plugin-*.jar", 1),
	}

	local java_test_bundles = vim.split(vim.fn.glob(java_test_dir .. "/*.jar", 1), "\n")

	local excluded = {
		"com.microsoft.java.test.runner-jar-with-dependencies.jar",
		"jacocoagent.jar",
	}
	for _, java_test_jar in ipairs(java_test_bundles) do
		local fname = vim.fn.fnamemodify(java_test_jar, ":t")
		if not vim.tbl_contains(excluded, fname) then
			table.insert(bundles, java_test_jar)
		end
	end

	return {
		bundles = bundles,
	}
end

M.settings = function()
	return {
		java = {
			format = {
				settings = {
					url = "/.local/share/eclipse/eclipse-java-google-style.xml",
					profile = "GoogleStyle",
				},
			},
			signatureHelp = { enabled = true },
			contentProvider = { preferred = "fernflower" },
			completion = {
				favoriteStaticMembers = {
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.*",
				},
				filteredTypes = {
					"com.sun.*",
					"io.micrometer.shaded.*",
					"java.awt.*",
					"jdk.*",
					"sun.*",
				},
			},
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
				hashCodeEquals = {
					useJava7Objects = true,
				},
				useBlocks = true,
			},
			configuration = {
				runtimes = M.runtimes(),
			},
		},
	}
end

M.configure = function()
	return {
		flags = {
			debounce_text_changes = 80,
		},
		capabilities = M.capabilities(),
		on_attach = M.on_attach(),
		root_dir = M.get_root_dir(),
		settings = M.settings(),
		cmd = M.cmd(),
		init_options = M.init_options(),
	}
end

return M
