local M = {}

-- @return the web executable
M.get_web_executable = function()
	local is_os_linux = vim.fn.has("linux") > 0
	local is_os_mac = vim.fn.has("mac") > 0

	if is_os_linux then
		return "/usr/bin/firefox"
	end
	if is_os_mac then
		return "/Applications/Firefox.app/Contents/MacOS/firefox"
	end
end

M.configure = function()
	local has_dap, dap = pcall(require, "dap")

	if not has_dap then
		return
	end

	vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "", linehl = "", numhl = "" })
	vim.fn.sign_define("DapStopped", { text = "󰐎", texthl = "" })

	dap.configurations.java = {
		{
			type = "java",
			request = "attach",
			name = "Debug (Attach) - Remote",
			hostName = "127.0.0.1",
			port = 7777,
		},
	}

	-- dap.adapters.java = function(callback)
	-- 	callback({
	-- 		type = "server",
	-- 		host = "127.0.0.1",
	-- 		port = 7777,
	-- 	})
	-- end

	dap.adapters.firefox = {
		type = "executable",
		command = "node",
		args = { vim.fn.stdpath("data") .. "/mason/packages/firefox-debug-adapter/dist/adapter.bundle.js" },
	}

	for _, language in ipairs({ "typescript", "typescriptreact", "javascript", "javascriptreact" }) do
		dap.configurations[language] = {
			{
				name = "Debug with Firefox",
				type = "firefox",
				request = "launch",
				reAttach = true,
				url = "http://localhost:5173",
				webRoot = "${workspaceFolder}",
				firefoxExecutable = M.get_web_executable(),
			},
		}
	end
end

return M
