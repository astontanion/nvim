local M = {}

M.configure = function()
	local has_which_key, which_key = pcall(require, "which-key")
	local has_dap, dap = pcall(require, "dap")

	if not has_which_key then
		return
	end
	if not has_dap then
		return
	end

	local debug_keys = {
		{ mode = "n" },
		{ lhs = "<leader>d", group = "debug" },
		{ lhs = "<leader>db", rhs = dap.toggle_breakpoint, desc = "Breakpoint" },
		{ lhs = "<leader>dc", rhs = dap.continue, desc = "Continue" },
		{ lhs = "<leader>di", rhs = dap.step_into, desc = "Step into" },
		{ lhs = "<leader>dj", rhs = dap.step_over, desc = "Step over" },
		{ lhs = "<leader>do", rhs = dap.step_out, desc = "Step out" },
		{ lhs = "<leader>dr", rhs = dap.step_back, desc = "Step Back" },
		{ lhs = "<leader>dt", rhs = dap.terminate, desc = "Terminate" },
	}

	which_key.add(debug_keys)
end

return M
