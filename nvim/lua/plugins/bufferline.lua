require("bufferline").setup({
	options = {
		mode = "buffers",
		numbers = "none",
		close_command = "bdelete! %d",
		diagnostics = false,
		style_preset = require("bufferline").style_preset.no_italic,
		show_close_icon = false,
		right_mouse_command = false,
		middle_mouse_command = false,
		buffer_close_icon = "󰅖",
		modified_icon = "●",
		close_icon = "",
		separator_style = "thin",
		indicator = { style = "none" },
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				text_align = "left",
			},
		},
	},
})
