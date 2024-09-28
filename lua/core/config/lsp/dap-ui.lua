local M = {}

M.configure = function()
	local has_dap, dap = pcall(require, "dap")
	local has_dapui, dapui = pcall(require, "dapui")

	if not has_dap then
		return
	end
	if not has_dapui then
		return
	end

	dapui.setup()

	local debug_tab = nil

	local open_debugger = function()
		if debug_tab and vim.api.nvim_tabpage_is_valid(debug_tab) then
			vim.api.nvim_set_current_tabpage(debug_tab)
			return
		end

		vim.cmd("tabedit %")
		local debug_window = vim.fn.win_getid()
		debug_tab = vim.api.nvim_win_get_tabpage(debug_window)

		dapui.open()
	end

	local close_debugger = function()
		dapui.close()

		if debug_tab and vim.api.nvim_tabpage_is_valid(debug_tab) then
			vim.api.nvim_exec2("tabclose " .. vim.api.nvim_tabpage_get_number(debug_tab), { output = false })
		end

		debug_tab = nil
	end

	dap.listeners.after.event_initialized["dapui_config"] = function()
		open_debugger()
	end

	dap.listeners.before.event_terminated["dapui_config"] = function()
		close_debugger()
	end

	dap.listeners.before.event_exited["dapui_config"] = function()
		close_debugger()
	end
end

return M
