-- return {
-- 	"Exafunction/codeium.nvim",
-- 	dependencies = {
-- 		"nvim-lua/plenary.nvim",
-- 		"hrsh7th/nvim-cmp",
-- 	},
-- 	config = function()
-- 		require("codeium").setup({
-- 			-- Optionally disable cmp source if using virtual text only
-- 			enable_cmp_source = false,
-- 			virtual_text = {
-- 				enabled = true,
--
-- 				-- A mapping of filetype to true or false, to enable virtual text.
-- 				filetypes = {
-- 					-- markdown = false,
-- 				},
-- 				default_filetype_enabled = true,
--
-- 				-- How long to wait (in ms) before requesting completions after typing stops.
-- 				idle_delay = 75,
--
-- 				-- Set to false to disable all key bindings for managing completions.
-- 				map_keys = true,
--
-- 				-- Key bindings for managing completions in virtual text mode.
-- 				key_bindings = {
-- 					-- Accept the current completion.
-- 					accept = "<C-f>",
-- 					-- Accept the next word.
-- 					accept_word = "<C- >",
-- 					-- Accept the next line.
-- 					accept_line = false,
-- 					-- Clear the virtual text.
-- 					clear = "<C-x>",
-- 					-- Cycle to the next completion.
-- 					next = "<C-.>",
-- 					-- Cycle to the previous completion.
-- 					prev = "<C-,>",
-- 				},
-- 			},
-- 		})
-- 	end,
-- }

-- DEPRECATED vimscript alternative (use this until the other supports toggle enable/disable)
vim.g.codeium_no_map_tab = 1 -- Set the global variable before returning the configuration
return {
	"Exafunction/codeium.vim",
	config = function()
		-- ctrl+f to accept the completion
		vim.keymap.set("i", "<C-f>", function()
			return vim.fn["codeium#Accept"]()
		end, { expr = true, silent = true })
		-- ctrl+; and ctrl+, to cycle completions
		vim.keymap.set("i", "<c-.>", function()
			return vim.fn["codeium#CycleCompletions"](1)
		end, { expr = true, silent = true })
		vim.keymap.set("i", "<c-,>", function()
			return vim.fn["codeium#CycleCompletions"](-1)
		end, { expr = true, silent = true })
		-- ctrl+x to reject completion
		vim.keymap.set("i", "<c-x>", function()
			return vim.fn["codeium#Clear"]()
		end, { expr = true, silent = true })
	end,
}
