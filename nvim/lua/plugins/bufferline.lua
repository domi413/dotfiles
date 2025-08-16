require("bufferline").setup({
	options = {
		mode = "tabs",
		numbers = "none",
		close_command = "tabclose %d",
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
	},
})
