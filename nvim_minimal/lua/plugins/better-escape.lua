return {
	"max397574/better-escape.nvim",
	event = "InsertEnter",
	config = function()
		require("better_escape").setup({
			mappings = {
				i = {
					j = {
						j = false, -- disable jj to leave insert
						k = "<ESC>",
					},
				},
				t = { j = { false } }, --lazygit navigation fix
				v = { j = { k = false } }, -- visual select fix
				s = { j = { k = false } }, -- selection mode (snippets) fix
			},
		})
	end,
}
