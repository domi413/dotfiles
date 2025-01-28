return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		-- Count selected lines and characters in visual mode
		local function selectionCount()
			local mode = vim.api.nvim_get_mode().mode
			if not mode:find("[Vv\22]") then
				return ""
			end
			local start_line = vim.fn.line("v")
			local end_line = vim.fn.line(".")
			local lines = math.abs(end_line - start_line) + 1
			local chars = vim.fn.wordcount().visual_chars or 0
			return lines .. "Ln:" .. chars .. "C"
		end

		-- Check if Codeium plugin is loaded, fallback if not
		local function codeiumStatus()
			local ok, codeium = pcall(require, "codeium.virtual_text")
			if ok and codeium.status_string then
				return codeium.status_string()
			end
			return ""
		end

		require("lualine").setup({
			options = {
				theme = "auto",
				component_separators = "",
				section_separators = { left = "", right = "" },
				disabled_filetypes = { "NvimTree" },
			},
			sections = {
				lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
				lualine_b = { "filename", "branch", "diagnostics" },
				lualine_c = { "%=" },
				lualine_x = {},
				lualine_y = {
					codeiumStatus,
					"filetype",
					"progress",
				},
				lualine_z = {
					{ selectionCount },
					{ "location", separator = { right = "" }, left_padding = 2 },
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = { "filename" },
				lualine_c = {
					function()
						local width = vim.fn.winwidth(0)
						local filenamestr = vim.fn.expand("%:t")
						local filename_len = filenamestr ~= "" and #filenamestr or 9
						local location_len = #tostring(vim.fn.line("."))
						local modified_len = vim.bo.modified and 4 or 0

						return string.rep("-", width - (filename_len + location_len + modified_len + 11))
					end,
				},
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
