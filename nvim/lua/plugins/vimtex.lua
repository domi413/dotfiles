return {
	"lervag/vimtex",
	lazy = false,
	init = function()
		-- Set zathura as pdf viewer
		vim.g.vimtex_view_method = "zathura"

		-- Disable continuous compilation with latexmk by using tectonic
		vim.g.vimtex_compiler_method = "tectonic"

		-- Use treesitter for syntax highlighting
		vim.g.vimtex_syntax_enabled = 0
		vim.g.vimtex_syntax_conceal_disable = 1

		-- vim.g.vimtex_compiler_method = "latexrun"

		-- Set xelatex as default compiler
		-- tectonic already has xelatex as default
		-- vim.g.vimtex_compiler_latexrun_engines = {
		-- 	["_"] = "-xelatex",
		-- }
		-- vim.g.vimtex_compiler_latexmk_engines = {
		-- 	["_"] = "-xelatex",
		-- }
	end,
}
