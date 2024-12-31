-- ╭──────────────────────────────────────────────────────────╮
-- │ Options                                                  │
-- ╰──────────────────────────────────────────────────────────╯
-- Here are some general editor configs defined like
-- relative-numbers and clipbboard-support

local opt = vim.opt -- for conciseness

-- ╭──────────────────────────────────────────────────────────╮
-- │ Show indentation                                         │
-- ╰──────────────────────────────────────────────────────────╯
local use_dot = false -- Set this to `false` to use spaces instead of dots
local lead_char = use_dot and "·" or " "

local function update_lead()
	local tabstop = vim.o.tabstop

	local lead_space = "│" .. string.rep(lead_char, tabstop - 1)

	vim.opt.listchars = vim.tbl_extend("force", vim.opt.listchars:get(), {
		leadmultispace = lead_space,
	})
end

-- Update the lead when tabstop or filetype changes
vim.api.nvim_create_autocmd("OptionSet", {
	-- pattern = { "listchars", "tabstop", "filetype" },
	callback = function()
		local filename = vim.fn.expand("%")
		if filename ~= "" then
			update_lead()
		end
	end,
})

-- Run the update_lead at start
vim.api.nvim_create_autocmd("VimEnter", {
	callback = update_lead,
	once = true,
})

vim.opt.list = true
vim.opt.listchars = {
	-- eol = "↲",
	leadmultispace = "│ ", -- Placeholder until updated by update_lead
	tab = "│" .. lead_char,
}

-- ╭──────────────────────────────────────────────────────────╮
-- │ Mouse                                                    │
-- ╰──────────────────────────────────────────────────────────╯
vim.cmd([[
  aunmenu PopUp.How-to\ disable\ mouse
  aunmenu PopUp.-1-
]])
opt.mouse = "a"

-- ╭──────────────────────────────────────────────────────────╮
-- │ Disable the "~" character at blank lines                 │
-- ╰──────────────────────────────────────────────────────────╯
opt.fillchars = {
	fold = " ",
	vert = "│",
	eob = " ",
	msgsep = "‾",
}

-- ╭──────────────────────────────────────────────────────────╮
-- │ Line wrap                                                │
-- ╰──────────────────────────────────────────────────────────╯
-- Wrap the whole word and don't split the word in half
opt.linebreak = true

-- ╭──────────────────────────────────────────────────────────╮
-- │ Command line                                             │
-- ╰──────────────────────────────────────────────────────────╯
-- Disable command line bar
opt.cmdheight = 0

-- ╭──────────────────────────────────────────────────────────╮
-- │ Indentation                                              │
-- ╰──────────────────────────────────────────────────────────╯
-- Specify size of an indent when using >> and <<
opt.shiftwidth = 4

-- Number of spaces a tab counts for
opt.tabstop = 4

-- Convert tabs to spaces
opt.expandtab = true

-- ╭──────────────────────────────────────────────────────────╮
-- │ Relative numbers                                         │
-- ╰──────────────────────────────────────────────────────────╯
-- Show relative line numbers
opt.relativenumber = true

-- Show absoulte line number on cursor (current) line (when relative line number is on)
opt.number = true

-- ╭──────────────────────────────────────────────────────────╮
-- │ Line wrapping                                            │
-- ╰──────────────────────────────────────────────────────────╯
opt.wrap = false

-- ╭──────────────────────────────────────────────────────────╮
-- │ Disable Login screen ("Help poor children in Uganda")    │
-- ╰──────────────────────────────────────────────────────────╯
opt.shortmess:append("I")

-- ╭──────────────────────────────────────────────────────────╮
-- │ Search preferences                                       │
-- ╰──────────────────────────────────────────────────────────╯
-- Ignores case when searching
-- e.g. -> print(Hello) will be found when searching \hello
opt.ignorecase = true

-- Case sensitive search when writing with mixed cases
-- e.g. -> print(LaTex) , \LATEX (will be false)
opt.smartcase = true

-- ╭──────────────────────────────────────────────────────────╮
-- │ Cursor line                                              │
-- ╰──────────────────────────────────────────────────────────╯
-- Highlights the current cursor line
opt.cursorline = true

-- ╭──────────────────────────────────────────────────────────╮
-- │ Cursor line                                              │
-- ╰──────────────────────────────────────────────────────────╯
-- Turn on termguicolors for nightfly colorscheme to work
-- (Have to use a true color terminal)
opt.termguicolors = true

-- ╭──────────────────────────────────────────────────────────╮
-- │ Clipboard                                                │
-- ╰──────────────────────────────────────────────────────────╯
-- Use system clipboard as default register
-- This options allows to copy text from neovim and paste it
-- in an external application e.g. chatGPT :)
opt.clipboard = "unnamedplus"

-- ╭──────────────────────────────────────────────────────────╮
-- │ Windows tiling                                           │
-- ╰──────────────────────────────────────────────────────────╯
opt.splitright = true
opt.splitbelow = true

-- ╭──────────────────────────────────────────────────────────╮
-- │ Swap file                                                │
-- ╰──────────────────────────────────────────────────────────╯
opt.swapfile = false
