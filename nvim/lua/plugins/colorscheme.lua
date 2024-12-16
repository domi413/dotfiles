return {
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- load the colorscheme here
			vim.cmd("colorscheme catppuccin")
		end,
	},
	{ "rose-pine/neovim" },
	{ "loctvl842/monokai-pro.nvim" },
	-- { "olivercederborg/poimandres.nvim" },
	-- { "scottmckendry/cyberdream.nvim" }, -- would be great theme for blurred background
}
