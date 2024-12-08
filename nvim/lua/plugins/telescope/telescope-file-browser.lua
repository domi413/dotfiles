return {
	"nvim-telescope/telescope-file-browser.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local fb_actions = require("telescope._extensions.file_browser.actions")

		require("telescope").setup({
			extensions = {
				file_browser = {
					path = vim.loop.cwd(),
					cwd = vim.loop.cwd(),
					cwd_to_path = true,
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
							-- The copy option here is absolutely bullshit, therefore use nvim-tree for this task
							-- How do I select files??!!
							["<C-a>"] = fb_actions.create,
							["<C-r>"] = fb_actions.rename,
							["<C-d>"] = fb_actions.remove,
							["<C-o>"] = fb_actions.open, -- Open file with system application
							["<C-h>"] = fb_actions.goto_parent_dir,
							["<C-l>"] = fb_actions.open_dir,
							["<C-^>"] = fb_actions.goto_home_dir,
							["<C-.>"] = fb_actions.toggle_hidden,
						},
					},
				},
			},
		})
	end,
}
