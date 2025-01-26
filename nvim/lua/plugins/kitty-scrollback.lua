return {
	"mikesmithgh/kitty-scrollback.nvim",
	enabled = true,
	lazy = true,
	cmd = {
		"KittyScrollbackGenerateKittens",
		"KittyScrollbackCheckHealth",
		"KittyScrollbackGenerateCommandLineEditing",
	},
	event = { "User KittyScrollbackLaunch" },
	config = function()
		require("kitty-scrollback").setup({
			search = {
				callbacks = {
					after_ready = function()
						vim.api.nvim_feedkeys("?", "n", false)
					end,
				},
			},
		})
	end,
}
