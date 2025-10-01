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

-- Editor / Editing
map("n", "<leader>nh", "<cmd>nohl<CR>", { desc = "Clear search highlights" })
map("n", "<leader>o", "o<Esc>", { desc = "Insert line above" })
map("n", "<leader>O", "O<Esc>", { desc = "Insert line below" })
map("n", "<leader>e", "<cmd>Yazi<cr>", { desc = "Open Yazi" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
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
map("n", "<leader>to", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Toggle outline (Functions)" })

-- Vimtex
map("n", "<leader>lc", "<cmd>w | VimtexCompile<CR><CR>", { desc = "Start compilation" })
map("n", "<leader>lp", "<cmd>VimtexView<CR>", { desc = "Jump in PDF to current position" })
map("n", "<leader>lC", "<cmd>VimtexClean<CR><CR>", { desc = "Cleanup files" })

map("n", "<leader>lt", function()
	vim.cmd("VimtexTocToggle")
	vim.cmd("wincmd h")
end, { desc = "Toggle TOC" })

-- Clear registers
vim.keymap.set("n", "cr", function()
	local regs = 'abcdefghijklmnopqrstuvwxyz0123456789/-"*+'
	for i = 1, #regs do
		local reg = regs:sub(i, i)
		vim.fn.setreg(reg, {})
	end
	print("All registers cleared!")
end, { desc = "Clear all registers", noremap = true })

-- LSP
if vim.lsp.inlay_hint then
	map("n", "<leader>tt", function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
	end, { desc = "Toggle inlay hints" })
end

-- Git
map("n", "gl", "<cmd>LazyGit<CR>", { desc = "LazyGit" })
map("n", "gB", "<cmd>Gitsigns blame_line<CR>", { desc = "Show blame" })

map("n", "gh", function()
	vim.cmd("Gitsigns toggle_word_diff")
	vim.cmd("Gitsigns toggle_deleted")
	vim.cmd("Gitsigns toggle_linehl")
end, { desc = "Toggle show changes" })

-- Dial (Enhanced increment/decrement)
vim.keymap.set("n", "<C-x>", function()
	require("dial.map").manipulate("decrement", "normal")
end)
vim.keymap.set("n", "<C-a>", function()
	require("dial.map").manipulate("increment", "normal")
end)

-- ╭──────────────────────────────────────────────────────────╮
-- │ Plugins                                                  │
-- ╰──────────────────────────────────────────────────────────╯
vim.pack.add({
	-- TODO: Improve dependency handling
	-- Git
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/kdheepak/lazygit.nvim" },

	-- LSP, Auto-completion & Formatter
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
	{ src = "https://github.com/akinsho/git-conflict.nvim" },
	{ src = "https://github.com/Exafunction/windsurf.nvim" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
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
	{ src = "https://github.com/max397574/better-escape.nvim" },
	{ src = "https://github.com/mikavilpas/yazi.nvim" },
	{ src = "https://github.com/monaqa/dial.nvim" },
	{ src = "https://github.com/numToStr/Comment.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/rmagatti/auto-session" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
})

-- ╭──────────────────────────────────────────────────────────╮
-- │ Configurations                                           │
-- ╰──────────────────────────────────────────────────────────╯
vim.cmd("colorscheme catppuccin-mocha")

require("plugins.cmp")
require("plugins.flash")
require("plugins.formatter")
require("plugins.lspconfig")
require("plugins.lualine")
require("plugins.scroll")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.vimtex")

require("auto-session").setup()
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
require("Comment").setup()

local augend = require("dial.augend")
require("dial.config").augends:register_group({
	default = {
		augend.integer.alias.decimal,
		augend.integer.alias.hex,
		augend.constant.alias.bool,
		augend.constant.new({
			elements = { "True", "False" },
			word = true,
			cyclic = true,
		}),
		augend.date.new({
			pattern = "%Y/%m/%d",
			default_kind = "day",
		}),
		augend.date.new({
			pattern = "%Y-%m-%d",
			default_kind = "day",
		}),
		augend.hexcolor.new({
			case = "prefer_upper",
		}),
	},
})
require("dressing").setup()
require("git-conflict").setup({})
require("gitsigns").setup({
	current_line_blame = true,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
		virt_text_priority = 100,
		use_focus = true,
	},
	current_line_blame_formatter = "<author>, <abbrev_sha> - <summary>",
	preview_config = { border = "rounded" },
	gh = true,
})
require("ibl").setup({
	scope = { enabled = false },
})
require("marks").setup() ---@diagnostic disable-line: undefined-field
require("mason").setup()
require("mason-lspconfig").setup({
	automatic_enable = {
		exclude = {
			"clangd",
			"cspell_ls",
			"gopls",
		},
	},
})
require("nvim-autopairs").setup()
require("nvim-highlight-colors").setup({
	render = "virtual",
	virtual_symbol = " ⬤",
	virtual_symbol_position = "eow",
	enabled_tailwind = true,
})
require("nvim-surround").setup()
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
