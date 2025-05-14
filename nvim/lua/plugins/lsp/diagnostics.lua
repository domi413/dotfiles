return {
	"maan2003/lsp_lines.nvim",
	config = function()
		vim.diagnostic.config({ virtual_text = true })
		local virtual_lines_enabled = false

		vim.keymap.set("n", "<Leader>dl", function()
			virtual_lines_enabled = not virtual_lines_enabled

			if virtual_lines_enabled then
				vim.diagnostic.config({ virtual_text = false })
				require("lsp_lines").toggle(true)
			else
				vim.diagnostic.config({ virtual_text = true })
				require("lsp_lines").toggle(false)
			end
		end, { desc = "Detailed diagnostics" })
	end,
}
