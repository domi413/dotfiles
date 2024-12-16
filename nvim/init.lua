-- Recommended settings from nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- ╭──────────────────────────────────────────────────────────╮
-- │ Include config files                                     │
-- ╰──────────────────────────────────────────────────────────╯
-- Setup vim.opt, keymaps, ... before loading lazy.nvim
-- so that mappings are correct.
require("core.disable_cutting")
require("core.options")
require("core.keymap")
require("core.run_code")
-- require("core.CMake")

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- ╭──────────────────────────────────────────────────────────╮
		-- │ Include plugins                                          │
		-- ╰──────────────────────────────────────────────────────────╯
		{ import = "plugins.treesitter" },
		{ import = "plugins" },
		{ import = "plugins.debugger" },
		{ import = "plugins.git" },
		{ import = "plugins.lsp" },
		{ import = "plugins.telescope" },
	},
	-- Configure any other settings here.
	-- colorscheme that will be used when installing plugins.
	-- install = { colorscheme = { "rose-pine" } },
	install = { colorscheme = { "catpuccin" } },

	-- automatically check for plugin updates
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})
