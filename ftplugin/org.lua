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
	name = "Agenda",
	o = {
		function()
			orgmode.action("agenda.prompt")
		end ,
		"Open"
	},
}

local org_capture_keys = {
	name = "Capture",
	c = {
		function()
			orgmode.capture.new()
		end,
		"Create"
	},
	e = {
		function()
			orgmode.action("capture.kill")
		end,
		"Exit"
	},
	f = {
		function()
			orgmode.action("capture.finalize")
		end,
		"Finish"
	},
	r = {
		function()
			orgmode.action("capture.refile")
		end,
		"Refile"
	},
	s = {
		function()
			orgmode.action("capture.show_help")
		end,
		"Show"
	}
}

local org_schedule_keys = {
	name = "Schedule",
	o = {
		function()
			orgmode.action("agenda.prompt")
		end ,
		"Open"
	}
}

local org_todo_keys = {
	name = "Todo",
	s = {
		function()
			orgmode.action("agenda.prompt")
		end ,
		"State"
	}
}

local org_mode_keys = {
	name = "Org mode",
	a = org_agenda_keys,
	c = org_capture_keys,
	s = org_schedule_keys,
	t = org_todo_keys
}


local mappings = {
	o = org_mode_keys
}

local options = {
	mode = "n",
	prefix = "<leader>",
	silent = true,
	noremap = true
}

which_key.register(mappings, options)
