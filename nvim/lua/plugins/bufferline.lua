return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- Function to detect amount of tabs
		function close_tab_if_multiple()
			-- Get the number of open tabs
			local tab_count = vim.fn.tabpagenr("$")
			if tab_count > 1 then
				vim.cmd("tabclose")
			else
				vim.api.nvim_echo({ { "Cannot close the last tab", "ErrorMsg" } }, false, {})
			end
		end

		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				mode = "tabs",

				-- numbers: none, ordinal(1, 2, 3), buffer_id, both, ...
				numbers = "none",
				close_command = "lua close_tab_if_multiple()",
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
