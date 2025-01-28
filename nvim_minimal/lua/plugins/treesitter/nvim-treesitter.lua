return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"windwp/nvim-ts-autotag",
	},
	config = function()
		require("nvim-treesitter.configs").setup({

			-- enable syntax highlighting
			highlight = {
				enable = true,

				-- Disable treesitter for files over 1MB
				disable = function(lang, buf)
					local max_filesize = 1000 * 1024 -- 1MB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,

				additional_vim_regex_highlighting = false,
			},

			-- enable indentation
			indent = { enable = true },

			-- ensure these language parsers are installed
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"css",
				"gitignore",
				"go",
				"html",
				"java",
				"javascript",
				"json",
				"latex",
				"lua",
				"markdown",
				"python",
				"csv",
				"rust",
				"typescript",
				"vim",
				"yaml",
			},

			sync_install = false,
			auto_install = true,

			-- Autotag setup
			require("nvim-ts-autotag").setup({
				enable = true,
				filetypes = {
					"html",
					"javascript",
					"javascriptreact",
					"typescriptreact",
					"svelte",
					"vue",
					"xml",
				},
			}),
		})
	end,
}
