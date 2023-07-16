local which_key_status, which_key = pcall(require, "which-key")

local orgmode_status, orgmode = pcall(require, "orgmode")

if not orgmode_status then
	return
end

if not which_key_status then
	return
end

local org_mode_keys = {
	name = "Agenda",
	a = {
		function()
			orgmode.action("agenda.prompt")
		end ,
		"Agenda"
	},
	s = {
		function()
			orgmode.action("agenda.prompt")
		end ,
		"Schedule"
	},
	ts = {
		function()
			orgmode.action("agenda.prompt")
		end ,
		"Todo state"
	},
}

local mappings = {
	o = org_mode_keys,
}

local options = {
	mode = "n",
	prefix = "<leader>",
	silent = true,
	noremap = true
}

which_key.register(mappings, options)
