return {
	"numToStr/Comment.nvim",
	config = function ()
		local config_status, config = pcall(require, "core.config.coding.comment")

		if not config_status then return end

		config.configure()
	end
}
