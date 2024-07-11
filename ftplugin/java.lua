vim.opt.breakindentopt = "shift:4"

local home = os.getenv("HOME")

local jdtls_status, jdtls = pcall(require, "jdtls")
local setup_status, setup = pcall(require, "jdtls.setup")
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp-nvim-lsp")

if not jdtls_status then return end
if not setup_status then return end

local jdtls_dir = vim.fn.stdpath("data") .. "/mason/packages/jdtls"

local root_markers = {"gradlew", "mvnw", ".git"}

local root_dir = setup.find_root(root_markers)

local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local capabilities = vim.lsp.protocol.make_client_capabilities()

if cmp_nvim_lsp_status then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

local dap_install_dir = vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter/extension/server"

local java_test_dir = vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server"

local on_attach = function(_, bufnr)
	local mapping_status, mapping = pcall(
		require,
		"core.keybinding.lspconfig"
	)

	if not mapping_status then return end

	mapping.configure(bufnr)

	local java_mapping_status, java_mapping = pcall(
		require,
		"core.keybinding.java"
	)

	if not java_mapping_status then return end

	java_mapping.configure()

	jdtls.setup_dap({
		hotcodereplace = 'auto',
		config_overrides = {}
	})
end

local bundles = {
	vim.fn.glob(
		dap_install_dir .. "/com.microsoft.java.debug.plugin-*.jar",
		1
	)
}

vim.list_extend(
	bundles,
	vim.split(
		vim.fn.glob(java_test_dir .. "/*.jar", 1),
		"\n"
	)
)

local is_os_linux = vim.fn.has("linux") > 0
local is_os_mac = vim.fn.has("mac") > 0

local get_config_type = function()
	if is_os_linux then return "/config_linux" end
	if is_os_mac then return "/config_mac" end
	return "/config_win"
end

local get_java_runtime = function()

	if is_os_linux then
		return {
			{
				name = "JavaSE-21",
				path = "/usr/lib/jvm/java-21-openjdk/",
			},
			{
				name = "JavaSE-17",
				path = "/usr/lib/jvm/java-17-openjdk/",
			}
		}
	end

	if is_os_mac then
		return {
			{
				name = "JavaSE-21",
				path = "/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home",
			},
		}
	end

	return {}
end

local config = {
	flags = {
		debounce_text_changes = 80,
	},
	capabilities = capabilities,
	on_attach = on_attach,
	root_dir = root_dir,
	settings = {
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
					"org.mockito.Mockito.*"
				},
				filteredTypes = {
					"com.sun.*",
					"io.micrometer.shaded.*",
					"java.awt.*",
					"jdk.*", "sun.*",
				},
			},
			sources = {
				organizeImports = {
					starThreshold = 9999;
					staticStarThreshold = 9999;
				},
			},
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
				},
				hashCodeEquals = {
					useJava7Objects = true,
				},
				useBlocks = true,
			},
			configuration = {
				runtimes = get_java_runtime()
			}
		}
	},
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx4g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens", "java.base/java.util=ALL-UNNAMED",
		"--add-opens", "java.base/java.lang=ALL-UNNAMED",
		"-jar", vim.fn.glob(jdtls_dir .. "/plugins/org.eclipse.equinox.launcher_*.jar", 1),
		"-configuration", jdtls_dir .. get_config_type(),
		"-data", workspace_folder,
	},
	init_options = {
		bundles = bundles
	}
}

jdtls.start_or_attach(config)
