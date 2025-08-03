-- ╭──────────────────────────────────────────────────────────╮
-- │ General configs                                          │
-- ╰──────────────────────────────────────────────────────────╯
-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

-- ╭──────────────────────────────────────────────────────────╮
-- │ Window tiling                                            │
-- ╰──────────────────────────────────────────────────────────╯
keymap.set("n", "<leader>sk", "<cmd>topleft split<cr>", { desc = "Split window up" })
keymap.set("n", "<leader>sj", "<cmd>split<cr>", { desc = "Split window down" })
keymap.set("n", "<leader>sl", "<cmd>vsplit<cr>", { desc = "Split window right" })
keymap.set("n", "<leader>sh", "<cmd>topleft vsplit<cr>", { desc = "Split window left" })
keymap.set("n", "<leader>sr", "<cmd>wincmd =<cr>", { desc = "Reset splitted window width / height" })
keymap.set("n", "<leader>x", "<cmd>bdelete!<CR>", { desc = "Close split/tab" })
-- keymap.set("n", "<leader>x", "<cmd>close<CR>", { desc = "Close split/tab" })

-- Resize splitted windows
keymap.set("n", "<leader>va", "<cmd>vertical resize +10<cr>", { desc = "Increase width of splitted window" })
keymap.set("n", "<leader>vx", "<cmd>vertical resize -10<cr>", { desc = "Decrease width of splitted window" })
keymap.set("n", "<leader>ha", "<cmd>resize +5<cr>", { desc = "Increase height of splitted window" })
keymap.set("n", "<leader>hx", "<cmd>resize -5<cr>", { desc = "Decrease height of splitted window" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ Buffer                                                   │
-- ╰──────────────────────────────────────────────────────────╯
-- Move buffer
keymap.set("n", "<Leader>>", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer to right" })
keymap.set("n", "<Leader><", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer to left" })

-- Buffer navigation
keymap.set("n", "<C-p>", "<cmd>BufferLineCycleNext<CR>")
keymap.set("n", "<C-n>", "<cmd>BufferLineCyclePrev<CR>")

-- New empty buffer
keymap.set("n", "<leader>nt", "<cmd>enew<CR>", { desc = "Open new tab with empty buffer" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ Tabs                                                     │
-- ╰──────────────────────────────────────────────────────────╯
-- keymap.set("n", "<leader>nt", "<cmd>tabnew<CR>", { desc = "Open new tab" })

-- Move Tabs
-- vim.keymap.set("n", "<Leader>>", "<cmd>tabmove +1<cr>", { desc = "Move tab to right" })
-- vim.keymap.set("n", "<Leader><", "<cmd>tabmove -1<cr>", { desc = "Move tab to left" })

-- Tab navigation
-- keymap.set("n", "<C-p>", "<cmd>tabn<CR>") -- Go to next tab
-- keymap.set("n", "<C-n>", "<cmd>tabp<CR>") -- To go previous tab

-- ╭──────────────────────────────────────────────────────────╮
-- │ Editing / Editor                                         │
-- ╰──────────────────────────────────────────────────────────╯
-- clear search highlights
keymap.set("n", "<leader>nh", "<cmd>nohl<cr>", { desc = "Clear search highlights" })

-- New Line (normal mode)
-- Insert a new line above/below without entering into insert-mode
keymap.set("n", "<leader>o", "o<Esc>", { desc = "Insert line above" })
keymap.set("n", "<leader>O", "O<Esc>", { desc = "Insert line below" })

-- Toggle case
keymap.set({ "n", "v", "s", "x" }, "<leader>i", "~", { desc = "Toggle case" })

-- Toggle line wrapping
keymap.set("n", "<leader>$", "<cmd>set wrap!<cr>", { desc = "Toggle line wrapping" })

-- Toggle outline
keymap.set("n", "<leader>to", "<cmd>Outline<cr>", { desc = "Toggle outline" })

-- Save file
keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })

-- Repeat last macro
keymap.set("n", "#", "@@", { desc = "Repeat last macro" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ Telescope                                                │
-- ╰──────────────────────────────────────────────────────────╯
-- Open fuzzy file finder
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })

-- Open fuzzy content finder
keymap.set("n", "<leader>fc", "<cmd>Telescope live_grep<cr>", { desc = "Fuzzy find content in cwd" })

-- Change color scheme
keymap.set("n", "<leader>ft", "<cmd>Telescope colorscheme enable_preview=true<cr>", { desc = "Change theme" })

-- Open registers
keymap.set("n", "<leader>fr", "<cmd>Telescope registers<cr>", { desc = "Open registers" })

-- Open marks
keymap.set("n", "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "Open marks" })

-- Browse TODO comments
keymap.set("n", "<leader>fg", "<cmd>TodoTelescope<cr>", { desc = "Browse TODO comments" })

-- Switch tabs
keymap.set("n", "<leader>st", "<cmd>Telescope buffers<cr>", { desc = "Switch buffer" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ Toggle spellchecker                                      │
-- ╰──────────────────────────────────────────────────────────╯
keymap.set("n", "<leader>ts", "<cmd>set spell!<cr>", { desc = "Toggle spellchecker" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ Treesitter                                               │
-- ╰──────────────────────────────────────────────────────────╯
-- treesitter motions are defined in
-- lua/plugins/treesitter/nvim-treesitter-text-objects.lua

-- ╭──────────────────────────────────────────────────────────╮
-- │ Git                                                      │
-- ╰──────────────────────────────────────────────────────────╯
-- Open LazyGit
keymap.set("n", "gl", "<cmd>LazyGit<cr>", { desc = "Open lazy git" })

-- Gitsigns
keymap.set("n", "<leader>gh", function()
	vim.cmd("Gitsigns toggle_deleted")
	vim.cmd("Gitsigns toggle_linehl")
end, { desc = "Toggle show changes" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ Disable cutting                                          │
-- ╰──────────────────────────────────────────────────────────╯
keymap.set("n", "x", '"_x')
