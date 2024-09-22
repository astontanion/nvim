local M = {}

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
			name = "Open liberty (attach) - remote",
			hostName = "127.0.0.1",
			port = 7777,
		},
	}

	dap.adapters.firefox = {
		type = "executable",
		command = "node",
		args = { vim.fn.stdpath("data") .. "/mason/packages/firefox-debug-adapter/dist/adapter.bundle.js" },
	}

	for _, language in ipairs({ "typescript", "javascript" }) do
		dap.configurations[language] = {
			{
				name = "Debug with Firefox",
				type = "firefox",
				request = "launch",
				reAttach = true,
				url = "http://localhost:5173",
				webRoot = "${workspaceFolder}",
				firefoxExecutable = "/Applications/Firefox.app/Contents/MacOS/firefox",
			},
		}
	end
end

return M
