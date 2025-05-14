return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"linrongbin16/lsp-progress.nvim",
	},

	config = function()
		-- Count selected lines and characters in visual mode
		local function selectionCount()
			local MAX_CHAR_COUNT = 2e+6

			local current_mode_char = vim.api.nvim_get_mode().mode

			local v_start_pos = vim.fn.getpos("v")
			local v_end_pos = vim.fn.getpos(".")

			local lines_selected_count = math.abs(v_start_pos[2] - v_end_pos[2]) + 1

			-- Assume 30 characters per line and set count limit to limit performance throttle
			if lines_selected_count * 30 > MAX_CHAR_COUNT then
				return tostring(lines_selected_count) .. " Ln : >" .. tostring(MAX_CHAR_COUNT) .. " C"
			end

			local region_lines = vim.fn.getregion(v_start_pos, v_end_pos, { type = current_mode_char })
			local char_count = 0

			for i, line in ipairs(region_lines) do
				if char_count <= MAX_CHAR_COUNT then
					char_count = char_count + vim.fn.strchars(line)
					if (current_mode_char == "v" or current_mode_char == "V") and i < #region_lines then
						char_count = char_count + 1
					end
				else
					char_count = MAX_CHAR_COUNT
					break
				end
			end
			return tostring(lines_selected_count)
				.. " Ln : "
				.. (char_count == MAX_CHAR_COUNT and ">" .. tostring(MAX_CHAR_COUNT) or tostring(char_count))
				.. " C"
		end

		-- Check if Codeium plugin is loaded, fallback if not
		local function codeiumStatus()
			local ok, codeium = pcall(require, "codeium.virtual_text")
			if ok and codeium.status_string then
				return codeium.status_string()
			end
			return ""
		end

		-- Set up Codeium statusbar refresh
		local ok, codeium = pcall(require, "codeium.virtual_text")
		if ok and codeium.set_statusbar_refresh then
			codeium.set_statusbar_refresh(function()
				require("lualine").refresh()
			end)
		end

		require("lsp-progress").setup({
			format = function(client_messages)
				local sign = ""
				local lsp_clients = vim.lsp.get_active_clients()
				local names = #client_messages > 0 and client_messages or {}

				if #client_messages == 0 and #lsp_clients > 0 then
					for _, client in ipairs(lsp_clients) do
						if type(client.name) == "string" and #client.name > 0 then
							table.insert(names, client.name)
						end
					end
					table.sort(names)
				end

				return #names > 0 and sign .. " " .. table.concat(names, ", ") or ""
			end,
		})

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
				lualine_c = {
					function()
						return require("lsp-progress").progress()
					end,
				},
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
