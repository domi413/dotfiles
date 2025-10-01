require("nvim-treesitter.configs").setup({
	modules = {},
	ignore_install = {},
	ensure_installed = {
		"bash",
		"c",
		"cmake",
		"cpp",
		"css",
		"gitignore",
		"go",
		"html",
		"javascript",
		"json",
		"latex",
		"lua",
		"markdown",
		"python",
		"toml",
		"typescript",
		"yaml",
	},

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

	indent = { enable = true },

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

	textobjects = {
		select = {
			enable = true,
			lookahead = true,

			keymaps = {
				["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
				["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

				["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
				["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

				["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
				["if"] = { query = "@function.inner", desc = "Select inner part of a function" },

				["aF"] = { query = "@frame.outer", desc = "Select outer part of a frame" },
				["iF"] = { query = "@frame.inner", desc = "Select inner part of a frame" },

				["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
				["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
			},
		},
		move = {
			enable = true,
			set_jumps = true,

			goto_next_start = {
				["]f"] = { query = "@call.outer", desc = "Next function call start" },
				["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
				["]c"] = { query = "@class.outer", desc = "Next class start" },
				["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
				["]l"] = { query = "@loop.outer", desc = "Next loop start" },

				["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
				["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
			},
			goto_next_end = {
				["]F"] = { query = "@call.outer", desc = "Next function call end" },
				["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
				["]C"] = { query = "@class.outer", desc = "Next class end" },
				["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
				["]L"] = { query = "@loop.outer", desc = "Next loop end" },
			},
			goto_previous_start = {
				["[f"] = { query = "@call.outer", desc = "Prev function call start" },
				["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
				["[c"] = { query = "@class.outer", desc = "Prev class start" },
				["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
				["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
			},
			goto_previous_end = {
				["[F"] = { query = "@call.outer", desc = "Prev function call end" },
				["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
				["[C"] = { query = "@class.outer", desc = "Prev class end" },
				["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
				["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
			},
		},
	},
})
