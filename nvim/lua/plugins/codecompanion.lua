return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},

	config = function()
		require("codecompanion").setup({
			display = {
				chat = {
					window = {
						width = 0.5,
					},
				},
			},
			adapters = {
				copilot = function()
					return require("codecompanion.adapters").extend("copilot", {
						schema = {
							model = {
								-- default = "claude-3.7-sonnet",
								default = "gemini-2.0-flash-001",
							},
						},
					})
				end,
			},
		})
	end,
}
