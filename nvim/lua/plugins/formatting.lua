return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				bash = { "shfmt" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				css = { "prettier" },
				go = { "golines" },
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
				latexindent = {
					-- install latexindent from package manager:
					-- texlive-binextra perl-yaml-tiny perl-file-homedir
					command = "latexindent",
					-- args = { "-m" },
					args = { "-m", '-y=defaultIndent:"    "' }, -- indent with 4 spaces
				},
				-- prettier = {
				-- 	prepend_args = function()
				-- 		return { "--tab-width", "4" }
				-- 	end,
				-- },
				ruff = {
					args = {
						"-c",
						"ruff check --select=I --fix --stdin-filename {buffer_path} | ruff format --stdin-filename {buffer_path}",
					},
				},
			},
			format_after_save = {
				lsp_fallback = true,
			},
		})
	end,
}
