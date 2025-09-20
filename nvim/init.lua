vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- ╭──────────────────────────────────────────────────────────╮
-- │ Options                                                  │
-- ╰──────────────────────────────────────────────────────────╯
local o = vim.opt

o.clipboard = "unnamedplus"
-- o.cmdheight = 0
o.cursorline = true
o.expandtab = true
o.ignorecase = true
o.linebreak = true -- Break whole word
o.number = true
o.relativenumber = true
o.shiftwidth = 4
o.shortmess:append("I")
o.signcolumn = "yes"
o.smartcase = true
o.spelllang = "en,de"
o.splitbelow = true
o.splitright = true
o.swapfile = false
o.tabstop = 4
o.termguicolors = true
o.undofile = true
o.wrap = false

-- Mouse
vim.cmd([[
  aunmenu PopUp.How-to\ disable\ mouse
  aunmenu PopUp.-2-
]])
o.mouse = "a"

-- ╭──────────────────────────────────────────────────────────╮
-- │ Keymaps                                                  │
-- ╰──────────────────────────────────────────────────────────╯
local map = vim.keymap.set

vim.g.mapleader = " "

-- Disable cutting
map("n", "x", '"_x')
map("n", "X", '"_x')

-- Window
map("n", "<C-p>", "<cmd>BufferLineCycleNext<CR>")
map("n", "<C-n>", "<cmd>BufferLineCyclePrev<CR>")
map("n", "<C-w>t", "<cmd>tabnew<CR>")

-- Editor / Editing
map("n", "<leader>nh", "<cmd>nohl<CR>", { desc = "Clear search highlights" })
map("n", "<leader>o", "o<Esc>", { desc = "Insert line above" })
map("n", "<leader>O", "O<Esc>", { desc = "Insert line below" })
map("n", "<leader>e", "<cmd>Yazi<cr>", { desc = "Open Yazi" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>to", "<cmd>Outline<CR>", { desc = "Toggle outline" })
map("n", "<leader>ts", "<cmd>set spell!<CR>", { desc = "Toggle spellchecker" })
map("n", "<leader>tu", "<cmd>UndotreeToggle<CR>", { desc = "Toggle undoTree" })
map("n", "<leader>tw", "<cmd>set wrap!<CR>", { desc = "Toggle line wrapping" })
map("n", "#", "@@", { desc = "Repeat last macro" })
map({ "n", "v", "s", "x" }, "<leader>i", "~", { desc = "Toggle case" })

-- Sessions
map("n", "<leader>fs", "<cmd>Telescope session-lens<CR>", { desc = "Search sessions" })
map("n", "<leader>ss", "<cmd>SessionSave<CR>", { desc = "Search sessions" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Fuzzy find files in cwd" })
map("n", "<leader>fc", "<cmd>Telescope live_grep<CR>", { desc = "Fuzzy find content in cwd" })
map("n", "<leader>ft", "<cmd>Telescope colorscheme enable_preview=true<CR>", { desc = "Change theme" })
map("n", "<leader>fr", "<cmd>Telescope registers<CR>", { desc = "Open registers" })
map("n", "<leader>fm", "<cmd>Telescope marks<CR>", { desc = "Open marks" })
map("n", "<leader>fg", "<cmd>TodoTelescope<CR>", { desc = "Browse TODO comments" })
map("n", "<leader>st", "<cmd>Telescope buffers<CR>", { desc = "Switch buffer" })

-- Vimtex
map("n", "<leader>lc", "<cmd>w | VimtexCompile<CR><CR>", { desc = "Start compilation" })
map("n", "<leader>lp", "<cmd>VimtexView<CR>", { desc = "Jump in PDF to current position" })
map("n", "<leader>lC", "<cmd>VimtexClean<CR><CR>", { desc = "Cleanup files" })

map("n", "<leader>lt", function()
	vim.cmd("VimtexTocToggle")
	vim.cmd("wincmd h")
end, { desc = "Toggle TOC" })

-- LSP
if vim.lsp.inlay_hint then
	map("n", "<leader>tt", function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
	end, { desc = "Toggle inlay hints" })
end

-- Git
map("n", "gl", "<cmd>LazyGit<CR>", { desc = "LazyGit" })

map("n", "gh", function()
	vim.cmd("Gitsigns toggle_deleted")
	vim.cmd("Gitsigns toggle_linehl")
end, { desc = "Toggle show changes" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ Plugins                                                  │
-- ╰──────────────────────────────────────────────────────────╯
vim.pack.add({
	-- TODO: Improve dependency handling

	-- Git
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/kdheepak/lazygit.nvim" },

	-- LSP, Auto-completion & Formatter
	{ src = "https://github.com/hedyhli/outline.nvim" },
	{ src = "https://github.com/maan2003/lsp_lines.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" }, -- dep: mason
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/stevearc/dressing.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" }, -- dep: mason

	-- Telescope
	{ src = "https://github.com/nvim-lua/plenary.nvim" }, -- dep: telescope
	-- TODO: currently, must be built manually by going to:
	--       ~/.local/share/nvim/site/pack/core/opt/telescope-fzf-native.nvim/
	--       and running `make`
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" }, -- dep: telescope
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" }, -- dep: telescope
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },

	-- Treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
	{ src = "https://github.com/windwp/nvim-ts-autotag" },

	-- Others
	{ src = "https://github.com/Exafunction/windsurf.nvim" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
	{ src = "https://github.com/akinsho/bufferline.nvim" },
	{ src = "https://github.com/brenoprata10/nvim-highlight-colors" },
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/chentoast/marks.nvim" },
	{ src = "https://github.com/folke/flash.nvim" },
	{ src = "https://github.com/folke/todo-comments.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/karb94/neoscroll.nvim" },
	{ src = "https://github.com/kylechui/nvim-surround" },
	{ src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
	{ src = "https://github.com/lervag/vimtex" },
	{ src = "https://github.com/linrongbin16/lsp-progress.nvim" },
	{ src = "https://github.com/max397574/better-escape.nvim" },
	{ src = "https://github.com/mbbill/undotree" },
	{ src = "https://github.com/mikavilpas/yazi.nvim" },
	{ src = "https://github.com/numToStr/Comment.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/rmagatti/auto-session" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
})

-- ╭──────────────────────────────────────────────────────────╮
-- │ Configurations                                           │
-- ╰──────────────────────────────────────────────────────────╯
vim.cmd("colorscheme catppuccin-mocha")

require("plugins.bufferline")
require("plugins.cmp")
require("plugins.git")
require("plugins.formatter")
require("plugins.lspconfig")
require("plugins.lsplines")
require("plugins.lualine")
require("plugins.scroll")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.vimtex")

require("Comment").setup()
require("auto-session").setup()
require("dressing").setup()
require("marks").setup()
require("mason").setup()
require("mason-lspconfig").setup()
require("nvim-autopairs").setup()
require("nvim-surround").setup()
require("plugins.flash")

require("better_escape").setup({
	mappings = {
		i = { j = { j = false, k = "<ESC>" } },
		t = { j = { false } }, --lazygit navigation fix
		v = { j = { k = false } }, -- visual select fix
		s = { j = { k = false } }, -- selection mode (snippets) fix
	},
})

require("codeium").setup({
	enable_cmp_source = false,
	virtual_text = {
		enabled = true,

		default_filetype_enabled = true,

		idle_delay = 75,

		key_bindings = {
			accept = "<C-f>",
			accept_word = "<C- >",
			accept_line = false,
			clear = "<C-x>",
			next = "<C-.>",
			prev = "<C-,>",
		},
	},
})

require("ibl").setup({
	scope = { enabled = false },
})

require("nvim-highlight-colors").setup({
	render = "virtual",
	virtual_symbol = " ⬤",
	virtual_symbol_position = "eow",
	enabled_tailwind = true,
})

require("outline").setup({
	preview_window = { live = true },
})

require("render-markdown").setup({
	code = { border = "thick" },
})

require("todo-comments").setup({
	search = { pattern = [[\b(KEYWORDS)(\([^\)]*\))?:]] },
	highlight = { pattern = [[.*<((KEYWORDS)%(\(.{-1,}\))?):]] },
})

require("which-key").setup({
	delay = 500,
	icons = { mappings = false },
})

require("yazi").setup({
	open_for_directories = true,
})
