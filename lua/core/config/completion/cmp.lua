local M = {}

M.configure = function()
	vim.opt.completeopt = "menu,menuone,noselect"

	local cmp_status, cmp = pcall(require, "cmp")
	local luasnip_status, luasnip = pcall(require, "luasnip")

	if not cmp_status then
		return
	end

	cmp.setup({
		snippet = {
			expand = function(args)
				if luasnip_status then
					luasnip.lsp_expand(args.body)
				end
			end,
		},
		sources = {
			{ name = "nvim_lsp" },
			{ name = "nvim_lsp_signature_help" },
			{ name = "orgmode" },
			{ name = "luasnip" },
		},
		mapping = cmp.mapping.preset.insert({
			["<C-j>"] = cmp.mapping.scroll_docs(-4),
			["<C-k>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			}),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end, { "i", "s" }),
		}),
	})
end

return M
