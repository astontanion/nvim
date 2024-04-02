return {
  'stevearc/dressing.nvim',
  opts = {},
  config = function()
	local config_status, config = pcall(require, "core.config.ui.dressing")

	if not config_status then return end

	config.configure()
  end
}
