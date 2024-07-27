local M = {}

M.configure = function()
	local luasnip_status, luasnip = pcall(require, "luasnip")

	if not luasnip_status then
		return
	end

	luasnip.setup()
end

return M
