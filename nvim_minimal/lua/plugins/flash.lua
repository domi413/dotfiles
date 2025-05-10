return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		jump = {
			autojump = false,
		},
		label = {
			uppercase = false,
		},
		highlight = {
			backdrop = false,
		},
		modes = {
			char = {
				-- Disable f,F,t,T motions
				enabled = false,
			},
		},
		prompt = {
			enabled = false,
		},
	},
	keys = {
		{
			-- Jump through code
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			-- Select code fragments
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
	},
	config = function(_, opts)
		require("flash").setup(opts)
		vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#e24efc" })
	end,
}
