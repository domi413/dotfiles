return {
	{
		"catppuccin/nvim",
		priority = 1000,

		-- Set default colorscheme
		config = function()
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
	-- {
	-- 	"folke/tokyonight.nvim",
	-- },
	-- {
	-- "onedarkpro.nvim",
	-- },
	-- {
	-- 	"catppuccin/nvim", -- already loaded as default
	-- },
	{
		"rebelot/kanagawa.nvim",
	},
	{
		"projekt0n/github-nvim-theme",
	},
	{
		"neanias/everforest-nvim",
	},
	{
		"rose-pine/neovim",
	},
}
