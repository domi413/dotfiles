require("conform").setup({
	formatters_by_ft = {
		bash = { "shfmt" },
		c = { "clang_format" },
		cmake = { "gersemi" },
		cpp = { "clang_format" },
		css = { "prettier" },
		cs = { "csharpier" },
		go = { "gopls" },
		html = { "prettier" },
		javascript = { "prettier" },
		json = { "prettier" },
		lua = { "stylua" },
		markdown = { "prettier" },
		python = { "ruff_format", "ruff_organize_imports" },
		-- rust = { "rustfmt" },
		tex = { "latexindent" },
		typescript = { "prettier" },
		yaml = { "prettier" },
	},
	formatters = {
		latexindent = {
			-- install latexindent from package manager:
			-- texlive-binextra perl-yaml-tiny perl-file-homedir
			command = "latexindent",
			args = function()
				local yaml_file = vim.fn.getcwd() .. "/.latexindent.yaml"
				if vim.fn.filereadable(yaml_file) == 1 then
					return { "-m", "-rv", "-l" }
				else
					return { "-m", '-y=defaultIndent:"\t",noAdditionalIndent:multicols:1' }
				end
			end,
		},
		ruff = {
			args = {
				"-c",
				"ruff\
				check\
				--select=I\
				--fix\
				--stdin-filename\
				{buffer_path}\
				| ruff format\
				--stdin-filename\
				{buffer_path}",
			},
		},
		csharpier = {
			command = "csharpier",
			args = { "format" },
		},
		gersemi = {
			command = "gersemi",
			args = {
				"--list-expansion=favour-expansion",
				"--no-warn-about-unknown-commands",
				"-", -- stdin
			},
		},
	},
	format_after_save = {
		lsp_fallback = true,
	},
})
