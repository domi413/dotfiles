return {
	"lervag/vimtex",
	lazy = false,
	init = function()
		-- Set zathura as pdf viewer
		vim.g.vimtex_view_method = "zathura"

		-- Set latex engine
		vim.g.vimtex_compiler_method = "tectonic"

		-- Use treesitter for syntax highlighting
		vim.g.vimtex_syntax_enabled = 0
		vim.g.vimtex_syntax_conceal_disable = 1

		-- TOC
		vim.g.vimtex_toc_config = {
			name = "Table of Contents",
			indent_levels = 1,
			show_help = 0,
			layer_status = {
				content = 1,
				label = 1,
				todo = 1,
				include = 0,
			},
		}
	end,
}
