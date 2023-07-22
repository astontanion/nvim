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

local on_attach = function(_, _)
	local which_key_status, which_key = pcall(require, "which-key")

	if which_key_status then

		local lsp_keys = {
			name = "Code",
			a = { vim.lsp.buf.code_action, "actions" },
			i = { vim.lsp.buf.implementation, "Go to implementation" },
			d = { vim.lsp.buf.declaration, "Go to declaration" },
			f = { vim.lsp.buf.definition, "Go to definition" },
			r = { vim.lsp.buf.rename, "Rename" },
			h = { vim.lsp.buf.hover, "Help" },
			t = { vim.lsp.buf.type_definition, "Type definition" },
			u = { vim.lsp.buf.references, "References" },
		}

		local jdtls_keys = {
			name = "Java",
			i = { jdtls.organize_imports, "Organize imports" },
			v = { jdtls.extract_variable, "Extract variable" },
			c = { jdtls.extract_constant, "Extract constant" },
			m = { jdtls.extract_method, "Extract method" }
		}

		local diagonostic_keys = {
			name = "error",
			o = { vim.diagnostic.open_float, "Open" },
			l = { vim.diagnostic.setloclist, "List" },
			n = { vim.diagnostic.goto_next, "Next" },
			p = { vim.diagnostic.goto_prev, "Previous"}
		}

		local test_keys = {
			name = "Test",
			c = {
				function()
					local file_path = vim.fn.expand("%:p")
					local test_path = string.gsub(file_path, "(%w+)%.java", "%1Test.java")
					test_path = string.gsub(test_path, "(/src/main/)", "/src/test/")
					vim.cmd(":e " .. test_path)
				end,
				"Create"
			}
		}

		local mappings = {
			c = lsp_keys,
			cj = jdtls_keys,
			ce = diagonostic_keys,
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

	jdtls.setup_dap({ hotcodereplace = 'auto' })
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
				runtimes = {
					{
						name = "JavaSE-17",
						path = "/usr/lib/jvm/java-17-openjdk/",
					},
					{
						name = "JavaSE-11",
						path = "/usr/lib/jvm/java-11-openjdk/",
					}
				}
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
		"-configuration", jdtls_dir .. "/config_linux",
		"-data", workspace_folder,
	},
	init_options = {
		bundles = {
			vim.fn.glob(dap_install_dir .. "/com.microsoft.java.debug.plugin-*.jar", 1)
		}
	}
}

jdtls.start_or_attach(config)
