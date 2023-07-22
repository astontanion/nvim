local has_dap, dap = pcall(require, "dap")

if not has_dap then return end

--vim.fn.sign_define('DapBreakpoint',{ text ='🟥', texthl ='', linehl ='', numhl =''})
--vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})

dap.configurations.java = {
	{
		type = "java",
		request = "attach",
		name = "Open liberty (attach) - remote",
		hostName = "127.0.0.1",
		port = 7777
	}
}





