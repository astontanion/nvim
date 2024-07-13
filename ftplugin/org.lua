vim.opt.breakindentopt = "shift:2"

local which_key_status, which_key = pcall(require, "which-key")

local orgmode_status, orgmode = pcall(require, "orgmode")

if not orgmode_status then
	return
end

if not which_key_status then
	return
end

local org_agenda_keys = {
	{ lhs = "<leader>a", group = "agenda" },
	{
		lhs = "<leader>ao",
		rhs = function()
			orgmode.action("agenda.prompt")
		end,
		desc = "Open",
	},
}

local org_capture_keys = {
	{ lhs = "<leader>c", group = "capture" },
	{
		lhs = "<leader>cc",
		rhs = function()
			orgmode.capture.new()
		end,
		desc = "Create",
	},
	{
		lhs = "<leader>ce",
		rhs = function()
			orgmode.action("capture.kill")
		end,
		desc = "Exit",
	},
	{
		lhs = "<leader>cf",
		rhs = function()
			orgmode.action("capture.finalize")
		end,
		desc = "Finish",
	},
	{
		lhs = "<leader>cr",
		rhs = function()
			orgmode.action("capture.refile")
		end,
		desc = "Refile",
	},
	{
		lhs = "<leader>cs",
		rhs = function()
			orgmode.action("capture.show_help")
		end,
		desc = "Show",
	},
}

local org_schedule_keys = {
	{ mode = "n" },
	{ lhs = "<leader>s", "schedule" },
	{
		lhs = "<leader>so",
		rhs = function()
			orgmode.action("agenda.prompt")
		end,
		desc = "Open",
	},
}

local org_todo_keys = {
	{ mode = "n" },
	{ lhs = "<leader>t", "todo" },
	{
		lhs = "<leader>ts",
		rhs = function()
			orgmode.action("agenda.prompt")
		end,
		desc = "State",
	},
}

local org_mode_keys = {
	org_agenda_keys,
	org_capture_keys,
	org_schedule_keys,
	org_todo_keys,
}

which_key.add(org_mode_keys)
