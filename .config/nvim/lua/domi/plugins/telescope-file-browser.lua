return {
	"nvim-telescope/telescope-file-browser.nvim",
	dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },

	config = function()
		local fb_actions = require("telescope._extensions.file_browser.actions")

		require("telescope").setup({
			extensions = {
				file_browser = {
					path = vim.loop.cwd(),
					cwd = vim.loop.cwd(),
					cwd_to_path = false,
					grouped = false,
					files = true,
					add_dirs = true,
					depth = 1,
					auto_depth = false,
					select_buffer = false,
					hidden = { file_browser = false, folder_browser = false },
					respect_gitignore = vim.fn.executable("fd") == 1,
					no_ignore = false,
					follow_symlinks = false,
					browse_files = require("telescope._extensions.file_browser.finders").browse_files,
					browse_folders = require("telescope._extensions.file_browser.finders").browse_folders,
					hide_parent_dir = false,
					collapse_dirs = false,
					prompt_path = false,
					quiet = false,
					dir_icon = "",
					dir_icon_hl = "Default",
					display_stat = { date = true, size = true, mode = true },
					hijack_netrw = false,
					use_fd = true,
					git_status = true,
					mappings = {
						["i"] = {
							["<C-c>"] = fb_actions.create, -- Create a new file / folder
							["<C-r>"] = fb_actions.rename,
							-- ["<C-m>"] = fb_actions.move, -- not working -> conflict with enter
							["<C-y>"] = fb_actions.copy, -- not sure what this does
							["<C-x>"] = fb_actions.remove, -- Deletes a file / folder
							["<C-o>"] = fb_actions.open, -- Open file with system application
							["<C-h>"] = fb_actions.goto_parent_dir, -- Go one dir back: cd ..
							["<C-^>"] = fb_actions.goto_home_dir, -- Go to ~/
							["<C-t>"] = fb_actions.change_cwd, -- not working sometimes (not sure if configs or plugin is shit)
							["<C-g"] = fb_actions.goto_cwd, --not working
							["<C-b>"] = fb_actions.toggle_browser, --  no clue what this does
							["<C-.>"] = fb_actions.toggle_hidden, -- Toggle hidden files
							["<C-s>"] = fb_actions.toggle_all, -- no clue what this does
							["<bs>"] = fb_actions.backspace, -- no clue what this does
							-- ["<esc>"] = fb_actions.change_cwd,
						},
						-- ["n"] = {
						-- 	["c"] = fb_actions.create,
						-- 	["r"] = fb_actions.rename,
						-- 	["m"] = fb_actions.move,
						-- 	["y"] = fb_actions.copy,
						-- 	["d"] = fb_actions.remove,
						-- 	["o"] = fb_actions.open,
						-- 	["h"] = fb_actions.goto_parent_dir,
						-- 	["e"] = fb_actions.goto_home_dir,
						-- 	["w"] = fb_actions.goto_cwd,
						-- 	["t"] = fb_actions.change_cwd,
						-- 	["f"] = fb_actions.toggle_browser,
						-- 	["g"] = fb_actions.toggle_hidden,
						-- ["s"] = fb_actions.toggle_all,
						-- ["<esc>"] = function(prompt_bufnr)   -- workaround not working yet
						-- 	fb_actions.change_cwd(prompt_bufnr)
						-- 	vim.api.nvim_feedkeys(
						-- 		vim.api.nvim_replace_termcodes("<esc>", true, false, true),
						-- 		"n",
						-- 		true
						-- 	)
						-- end,
						-- },
					},
				},
			},
		})
	end,
}
