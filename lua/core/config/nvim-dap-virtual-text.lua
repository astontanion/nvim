local has_virtual_text, virtual_text = pcall(require, "nvim-dap-virtual-text")

if not has_virtual_text then return end

virtual_text.setup()
