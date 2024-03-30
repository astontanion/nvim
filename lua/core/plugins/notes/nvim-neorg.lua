return {
	"nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
    lazy = false,
    version = "*",
    config = function()
		local config_status, config = pcall(require, "core.config.neorg")
		if not config_status then return end;
		config.configure()
	end
}
