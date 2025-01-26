return {
	"folke/zen-mode.nvim",
	opts = {
		window = {
			backdrop = 1,
			width = 0.8,
			height = 1,
			options = {},
		},
		on_open = function(win)
			local view = require("zen-mode.view")
			local layout = view.layout(view.opts)
			vim.api.nvim_win_set_config(win, {
				width = layout.width,
				height = layout.height - 1,
			})
			vim.api.nvim_win_set_config(view.bg_win, {
				width = vim.o.columns,
				height = view.height() - 1,
				row = 1,
				col = layout.col,
				relative = "editor",
			})
		end,
	},
}
