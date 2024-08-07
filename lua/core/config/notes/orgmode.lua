local M = {}
M.configure = function()
	local orgmode_status, orgmode = pcall(require, "orgmode")
	local which_key_status, which_key = pcall(require, "which-key")

	if not orgmode_status then
		return
	end

	orgmode.setup({
		org_agenda_files = {
			"~/doc/org/inbox.org",
			"~/doc/org/main.org",
			"~/doc/org/tickler.org",
		},
		org_default_notes_file = "~/doc/org/inbox.org",
		org_archive_location = "~/doc/org/archive.org",
		org_todo_keywords = {
			"TODO(t)",
			"INPROGRESS(p)",
			"WAITING(w)",
			"|",
			"DONE(d)",
			"CANCEL(c)",
		},
		win_split_mode = { "float", 0.75 },
		win_border = "rounded",
		org_startup_indented = true,
		org_capture_templates = {
			d = {
				description = "Thought",
				template = "* %?\n%U",
				target = "~/doc/org/inbox.org",
				headline = "Thoughts",
			},
			j = {
				description = "Journal",
				template = "* %?\nEntered on %U\n %a",
				target = "~/doc/org/journal.org",
			},
			t = {
				description = "Task",
				template = "* TODO %?",
				target = "~/doc/org/inbox.org",
				headline = "Tasks",
			},
			T = {
				description = "Tickler",
				template = "* %i%?\n %U",
				target = "~/doc/org/tickler.org",
				headline = "Tickler",
			},
		},
		mappings = {
			-- disable_all = true
		},
	})

	if which_key_status then
		which_key.add({
			{ lhs = "<leader>o", group = "orgmode" },
		})
	end
end

return M
