return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				bash = { "shfmt" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				-- cs = { "clang_format" },
				css = { "prettier" },
				graphql = { "prettier" },
				html = { "prettier" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				json = { "prettier" },
				lua = { "stylua" },
				markdown = { "prettier" },
				python = { "ruff_format", "ruff_organize_imports" },
				-- rust = { "rustfmt" },
				svelte = { "prettier" },
				tex = { "latexindent" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				yaml = { "prettier" },
			},
			formatters = {
				black = {
					prepend_args = function()
						return { "--fast" }
					end,
				},
				clang_format = {
					command = "clang-format",
					append_args = function()
						return {
							"--style={\
								BasedOnStyle: llvm,\
								IndentWidth: 4,\
								ColumnLimit: 80,\
								ReflowComments: false,\
								AlignArrayOfStructures: Left,\
								AlignConsecutiveMacros: Consecutive,\
								RemoveParentheses: ReturnStatement,\
							}",
						}
					end,
				},
				-- prettier = {
				-- 	prepend_args = function()
				-- 		return { "--tab-width", "4" }
				-- 	end,
				-- },
				latexindent = {
					-- install latexindent from package manager:
					-- texlive-binextra perl-yaml-tiny perl-file-homedir
					command = "latexindent",
					-- args = { "-m" },
					args = { "-m", '-y=defaultIndent:"    "' }, -- indent with 4 spaces
				},
			},
			format_after_save = {
				lsp_fallback = true,
			},
			-- format_on_save = {
			-- 	lsp_fallback = true,
			-- 	async = false,
			-- 	timeout_ms = 1000, -- Bigger timeout because black is slow af
			-- },
		})
	end,
}
