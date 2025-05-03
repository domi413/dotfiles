return {
	"Exafunction/windsurf.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
	},
	config = function()
		require("codeium").setup({
			enable_cmp_source = false,
			virtual_text = {
				enabled = true,

				filetypes = {
					-- markdown = false,
				},
				default_filetype_enabled = true,

				idle_delay = 75,

				key_bindings = {
					accept = "<C-f>",
					accept_word = "<C- >",
					accept_line = false,
					clear = "<C-x>",
					next = "<C-.>",
					prev = "<C-,>",
				},
			},
		})
	end,
}
