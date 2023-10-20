local org_bullets_status, org_bullets = pcall(require, "org-bullets")

if not org_bullets_status then
	return
end

org_bullets.setup {
	show_current_line = false,
	indent = true,
	concealcursor = true,
	symbols = {
		list = "•",
		headlines = { "◉", "✸", "✿", "○" },
		checkboxes = {
			half = { "", "OrgTSCheckboxHalfChecked" },
			done = { "✓", "OrgDone" },
			todo = { "˟", "OrgTODO" },
		},
	}
}
