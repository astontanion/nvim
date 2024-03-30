local M = {}

M.configure = function()
	local has_dap, dap = pcall(require, "dap")
	local has_dapui, dapui = pcall(require, "dapui")

	if not has_dap then return end
	if not has_dapui then return end

	dapui.setup()

	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end

	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end

	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end
end

return M
