return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				mode = "tabs",

				-- numbers: none, ordinal(1, 2, 3), buffer_id, both, ...
				numbers = "none",

				-- The following prolly will only work if mode is = "buffers"
				-- left_mouse_command = "buffer %d", -- drag tabs
				-- middle_mouse_command = "bdelete! %d", -- close tab

				buffer_close_icon = "󰅖",
				modified_icon = "●",
				close_icon = "",

				-- separator styles:
				--  `slant` - Use slanted/triangular separators
				--  `padded_slant` - Same as `slant` but with extra padding which some terminals require.
				--  If `slant` does not render correctly for you try padded this instead.
				--  `slope` - Use slanted/triangular separators but slopped to the right
				--  `padded_slope` - Same as `slope` but with extra padding which some terminals require.
				--  If `slope` does not render correctly for you try padded this instead.
				--  `thick` - Increase the thickness of the separator characters
				--  `thin` - (default) Use thin separator characters
				--  finally you can pass in a custom list containing 2 characters which will be
				--  used as the separators e.g. `{"|", "|"}`, the first is the left and the
				--  second is the right separator
				separator_style = "thin",
			},
		})
	end,
}
