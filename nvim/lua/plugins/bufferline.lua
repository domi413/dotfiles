return {
	"akinsho/bufferline.nvim",
	dependencies = {
    	"nvim-tree/nvim-web-devicons"
	},
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				mode = "buffers",

				-- numbers: none, ordinal(1, 2, 3), buffer_id, both, ...
				numbers = "none",
				close_command = "bdelete! %d",
				diagnostics = false,
				style_preset = bufferline.style_preset.no_italic,
				show_close_icon = false,

				-- Disable mouse commands
				-- left_mouse_command = false,
				right_mouse_command = false,
				middle_mouse_command = false,

				buffer_close_icon = "󰅖",
				modified_icon = "●",
				close_icon = "",

				separator_style = "thin",
				indicator = {
					style = "none",
				},

				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "left",
					},
				},
			},
		})
	end,
}
