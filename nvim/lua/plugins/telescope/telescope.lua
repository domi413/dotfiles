-- Define the darken_hex function to darken a hex color
local function darken_hex(hex, amount)
	local function hex_to_rgb(hex)
		hex = hex:gsub("#", "")
		return tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6))
	end

	local function rgb_to_hex(r, g, b)
		return string.format("#%02x%02x%02x", r, g, b)
	end

	local r, g, b = hex_to_rgb(hex)
	r = math.max(0, r - amount)
	g = math.max(0, g - amount)
	b = math.max(0, b - amount)
	return rgb_to_hex(r, g, b)
end

-- Define the update_telescope_highlights function to update the highlights
_G.update_telescope_highlights = function()
	local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
	if not bg then
		return
	end

	local bg_hex = string.format("#%06x", bg)
	local dark_bg = darken_hex(bg_hex, 10)
	local darker_bg = darken_hex(bg_hex, 15)

	vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = dark_bg })
	vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = dark_bg, fg = dark_bg })
	vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = darker_bg })
	vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = darker_bg, fg = darker_bg })
	vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = darker_bg, bg = darker_bg })
	vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = dark_bg, bg = dark_bg })
	vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = dark_bg, bg = dark_bg })
end

-- Define an autocommand to update highlights on colorscheme change
-- vim.cmd([[
--   augroup TelescopeCustomHighlights
--     autocmd!
--     autocmd ColorScheme * lua update_telescope_highlights()
--   augroup END
-- ]])

-- Call the function once to set the initial highlights
-- update_telescope_highlights()

-- Telescope configuration
return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		-- "nvim-tree/nvim-web-devicons",

		"DaikyXendo/nvim-material-icon",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		-- Define the custom horizontal_merged layout strategy
		require("telescope.pickers.layout_strategies").horizontal_merged = function(
			picker,
			max_columns,
			max_lines,
			layout_config
		)
			local layout =
				require("telescope.pickers.layout_strategies").horizontal(picker, max_columns, max_lines, layout_config)

			layout.prompt.title = ""
			layout.prompt.borderchars = { " ", " ", " ", " ", " ", " ", " ", " " }

			layout.results.title = ""
			layout.results.borderchars = { " ", " ", " ", " ", " ", " ", " ", " " }
			layout.results.line = layout.results.line - 1
			layout.results.height = layout.results.height + 1

			layout.preview.title = ""
			layout.preview.borderchars = { " ", " ", " ", " ", " ", " ", " ", " " }

			return layout
		end

		telescope.setup({
			defaults = {
				vimgrep_arguments = {
					"rg",
					"-L",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
				prompt_prefix = "   ",
				selection_caret = "  ",
				entry_prefix = "  ",
				initial_mode = "insert",
				selection_strategy = "reset",
				sorting_strategy = "ascending",

				-- layout_strategy: horizontal, vertical, center, cursor, horizontal_merged (custom (experimental))
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top", -- or bottom to display the search bar at the bottom
						preview_width = 0.55,
						results_width = 0.8,
						prompt_height = 2,
						prompt_title = "",
					},
					vertical = {
						mirror = false,
					},
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
				file_sorter = require("telescope.sorters").get_fuzzy_file,
				file_ignore_patterns = { "node_modules" },
				generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
				path_display = { "truncate" },
				winblend = 0,
				border = {},
				-- default borders
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				-- no borders
				-- borderchars = { "", "", "", "", "", "", "", "" },

				color_devicons = true,
				set_env = { ["COLORTERM"] = "truecolor" },
				file_previewer = require("telescope.previewers").vim_buffer_cat.new,
				grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
				buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<esc>"] = actions.close,
					},
					n = {
						["q"] = actions.close,
					},
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})

		-- Load extensions
		telescope.load_extension("fzf")
	end,
}
