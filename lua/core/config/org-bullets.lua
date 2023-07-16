local org_bullets_status, org_bullets = pcall(require, "org-bullets")

if not org_bullets_status then
	return
end

org_bullets.setup {
	concealcursor = false,
	symbols = {
		list = "•",
		headlines = { "◉", "○", "✸", "✿" },
		checkboxes = {
			half = { "", "OrgTSCheckboxHalfChecked" },
			done = { "✓", "OrgDone" },
			todo = { "˟", "OrgTODO" },
		},
	}
}
