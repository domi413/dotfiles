require("lsp_lines").setup()

local diagnostic_states = {
	enabled = true,
	inline = true,
}

local diagnostic_configs = {
	inline = { virtual_text = { true, prefix = "●" }, virtual_lines = false },
	detailed = { virtual_text = false, virtual_lines = true },
	disabled = { virtual_text = false, virtual_lines = false },
}

vim.diagnostic.config(diagnostic_configs.inline)

vim.keymap.set("n", "<Leader>dl", function()
	if diagnostic_states.enabled then
		diagnostic_states.inline = not diagnostic_states.inline
		vim.diagnostic.config(diagnostic_states.inline and diagnostic_configs.inline or diagnostic_configs.detailed)
	end
end, { desc = "Toggle detailed diagnostics" })

vim.keymap.set("n", "<Leader>td", function()
	diagnostic_states.enabled = not diagnostic_states.enabled
	vim.diagnostic.config(
		diagnostic_states.enabled
				and (diagnostic_states.inline and diagnostic_configs.inline or diagnostic_configs.detailed)
			or diagnostic_configs.disabled
	)
end, { desc = "Toggle diagnostics" })
