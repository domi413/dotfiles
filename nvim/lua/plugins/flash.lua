return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {

		jump = {
			autojump = false,
		},
		label = {
			upperase = false,
			-- format = function(opts)
			-- 	return { { string.lower(opts.match.label), opts.hl_group } }
			-- end,
		},
		highlight = {
			-- Keep normal highlighting
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
}
