return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local colors = {
			blue = "#80a0ff",
			cyan = "#79dac8",
			black = "#080808",
			white = "#c6c6c6",
			red = "#ff5189",
			violet = "#d183e8",
			grey = "#303030",
		}

		-- Custom theme
		local bubbles_theme = {
			normal = {
				a = { fg = colors.black, bg = colors.violet },
				b = { fg = colors.white, bg = colors.grey },
				c = { fg = colors.white },
			},

			insert = { a = { fg = colors.black, bg = colors.blue } },
			visual = { a = { fg = colors.black, bg = colors.cyan } },
			replace = { a = { fg = colors.black, bg = colors.red } },

			inactive = {
				a = { fg = colors.white, bg = colors.black },
				b = { fg = colors.white, bg = colors.black },
				c = { fg = colors.white },
			},
		}

		-- configure lualine with modified theme
		require("lualine").setup({
			options = {
				-- Other default themes e.g. : dracula, onedark, palenight, ...
				-- List of themes: https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
				-- NOTE: unlike the custom themes, the default themes must be set between "", e.g. "dracula"
				theme = bubbles_theme,
				component_separators = "",
				section_separators = { left = "", right = "" },
			},

			-- Parameters (information) available for lualine:
			-- branch         : shows the current Git branch
			-- buffers        : displays currently available buffers
			-- diagnostics    : shows diagnostics count from your preferred source (e.g., errors provided by a linter)
			-- diff           : displays the Git diff status
			-- encoding       : shows the file encoding (e.g., utf-8)
			-- fileformat     : visualizes the line break type (CRLF / LF) with an icon
			-- filename       : shows the filename with file extension
			-- filesize       : displays the size of the file
			-- filetype       : shows the filetype (language) with an icon
			-- hostname       : displays the hostname of the machine
			-- location       : shows the cursor position in the format line:column
			-- mode           : displays the current Vim mode (e.g., insert, normal)
			-- progress       : shows the cursor's % position based on file length
			-- searchcount    : displays the number of search matches when hlsearch is active
			-- selectioncount : shows the number of selected characters or lines
			-- tabs           : displays currently available tabs
			-- windows        : shows currently available windows
			-- %=             : defines the center

			sections = {
				lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } }, -- Bottom left corner
				lualine_b = { "filename", "branch", "diagnostics" }, -- Next to a
				lualine_c = { -- is the center
					"%=",
				},
				lualine_x = {}, -- Next to y
				lualine_y = { "filetype", "progress" }, -- Next to z
				lualine_z = {
					{ "location", separator = { right = "" }, left_padding = 2 }, -- Bottom right corner
				},
			},
			-- Informations shown in inactive tabs (is now disabled)
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = {},
		})
	end,
}
