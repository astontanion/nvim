local M = {}

M.configure = function()
	local has_which_key, which_key = pcall(require, "which-key")
	local has_dap, dap = pcall(require, "dap")

	if not has_which_key then return end
	if not has_dap then return end

	local debugger_keys = {
		name = "Debugger",
		b = { dap.toggle_breakpoint, "Breakpoint" },
		c = { dap.continue, "Continue" },
		i = { dap.step_into, "Step into" },
		j = { dap.step_over, "Step over" },
		o = { dap.step_out, "Step out" },
		r = { dap.step_back, "Step Back" },
		t = { dap.terminate, "Terminate" }
	}

	local mappings = {
		d = debugger_keys
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
