return {
	"maan2003/lsp_lines.nvim",
	config = function()
		-- vim.diagnostic.config({ virtual_lines = { only_current_line = true } })

		vim.diagnostic.config({ virtual_lines = { only_current_line = true } })

		vim.keymap.set("n", "<Leader>td", require("lsp_lines").toggle, { desc = "Toggle line diagnostics" })
	end,
}
