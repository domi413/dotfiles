-- ╭──────────────────────────────────────────────────────────╮
-- │ Options                                                  │
-- ╰──────────────────────────────────────────────────────────╯
-- Here are some general editor configs defined like
-- "relative numbers" and clipbboard-support

local opt = vim.opt -- for conciseness

-- ╭──────────────────────────────────────────────────────────╮
-- │ Disable the "~" character at blank lines                 │
-- ╰──────────────────────────────────────────────────────────╯
vim.opt.fillchars = {
	fold = " ",
	vert = "│",
	eob = " ",
	msgsep = "‾",
}

-- ╭──────────────────────────────────────────────────────────╮
-- │ Command line                                             │
-- ╰──────────────────────────────────────────────────────────╯
-- Disable command line bar
vim.opt.cmdheight = 0

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

-- Show absoulte line number on cursor line (when relative line number is on)
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
