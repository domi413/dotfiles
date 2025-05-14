return {
	"maan2003/lsp_lines.nvim",
	config = function()
		local diagnostic = vim.diagnostic.config

		diagnostic({ virtual_text = { true, prefix = "●" } })

		local virtual_lines_enabled = false
		vim.keymap.set("n", "<Leader>dl", function()
			virtual_lines_enabled = not virtual_lines_enabled

			if virtual_lines_enabled then
				diagnostic({ virtual_text = false })
				require("lsp_lines").toggle(true)
			else
				-- diagnostic({ virtual_text = true })
				diagnostic({ virtual_text = { true, prefix = "●" } })
				require("lsp_lines").toggle(false)
			end
		end, { desc = "Detailed diagnostics" })
	end,
}
