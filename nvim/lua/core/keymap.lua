-- ╭──────────────────────────────────────────────────────────╮
-- │ General configs                                          │
-- ╰──────────────────────────────────────────────────────────╯
-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

-- ╭──────────────────────────────────────────────────────────╮
-- │ Window tiling                                            │
-- ╰──────────────────────────────────────────────────────────╯
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>sr", "<C-w>=", { desc = "Reset splitted window width / height" })
keymap.set("n", "<leader>x", ":close<CR>", { desc = "Close splitted window" })

-- Resize splitted windows
keymap.set("n", "<leader>v+", ":vertical resize +10<CR>", { desc = "Increase width of splitted window" })
keymap.set("n", "<leader>v-", ":vertical resize -10<CR>", { desc = "Decrease width of splitted window" })
keymap.set("n", "<leader>h+", ":resize +5<CR>", { desc = "Increase height of splitted window" })
keymap.set("n", "<leader>h-", ":resize -5<CR>", { desc = "Decrease height of splitted window" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ Tab management                                           │
-- ╰──────────────────────────────────────────────────────────╯
keymap.set("n", "<leader>nt", ":tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>ct", ":tabclose<CR>", { desc = "Close tab" })

keymap.set("n", "<C-p>", ":tabn<CR>") -- Go to next tab
keymap.set("n", "<C-n>", ":tabp<CR>") -- To go previous tab

-- <Tab> and <C-i> are equivalent, therefore Tab overwrites ctrl+i,
-- use Ctrl+shift+i instead to get the same result as ctrl+i
-- keymap.set("n", "<Tab>", ":tabn<CR>") -- Go to next tab
-- keymap.set("n", "<S-Tab>", ":tabp<CR>") -- To go previous tab

-- ╭──────────────────────────────────────────────────────────╮
-- │ Editing / Editor                                         │
-- ╰──────────────────────────────────────────────────────────╯
-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- New Line (normal mode)
-- Insert a new line above/below without entering into insert-mode
keymap.set("n", "<leader>o", "o<Esc>", { desc = "Insert line above" })
keymap.set("n", "<leader>O", "O<Esc>", { desc = "Insert line below" })

-- Toggle case
keymap.set("n", "<leader>i", "~", { desc = "Toggle case" })
keymap.set("v", "<leader>i", "~", { desc = "Toggle case" })
keymap.set("s", "<leader>i", "~", { desc = "Toggle case" })
keymap.set("x", "<leader>i", "~", { desc = "Toggle case" })

-- NOTE:: Remap 'gx' to open links in the browser
-- This option should work per default with netrw but kinda doesn't work,
-- therefore I remapped it as a workaround
-- INFO: IT actually works now

-- keymap.set("n", "gx", ":sil !open <C-r><C-a><CR>", { desc = "Open URL under cursor" })

-- Toggle line wrapping
keymap.set("n", "<leader>$", ":set wrap!<CR>", { desc = "Toggle line wrapping" })

-- Toggle outline
keymap.set("n", "<leader>co", "<cmd>Outline<CR>", { desc = "Toggle outline" })

-- Save file
keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })

-- Repeat last macro
keymap.set("n", ",", "@@", { desc = "Repeat last macro" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ UndoTree                                                 │
-- ╰──────────────────────────────────────────────────────────╯
keymap.set("n", "<leader>ut", ":UndotreeToggle<CR>", { desc = "Toggle undoTree" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ Telescope                                                │
-- ╰──────────────────────────────────────────────────────────╯
-- Open file browser
-- keymap.set("n", "<leader>fe", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = "File Browser" })
keymap.set("n", "<leader>fe", ":Telescope file_browser select_buffer=true<CR>", { desc = "File Browser" })

-- Open fuzzy file finder
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })

-- Open fuzzy content finder
keymap.set("n", "<leader>fc", "<cmd>Telescope live_grep<cr>", { desc = "Fuzzy find content in cwd" })

-- Change color scheme
keymap.set("n", "<leader>ft", "<cmd>Telescope colorscheme enable_preview=true<cr>", { desc = "Change theme" })

-- Open registers
keymap.set("n", "<leader>fr", "<cmd>Telescope registers<cr>", { desc = "Open registers" })

-- Browse TODO comments
keymap.set("n", "<leader>fg", "<cmd>TodoTelescope<cr>", { desc = "Browse TODO comments" })

-- Switch tabs
vim.keymap.set("n", "<leader>st", function()
	require("telescope").extensions["telescope-tabs"].list_tabs()
end, { desc = "Switch tabs" })

-- Other Telescope keybindings are defined in lua/plugins/telescope.lua and
-- lua/plugins/telescope-file-browser.lua

-- ╭──────────────────────────────────────────────────────────╮
-- │ Vimtex                                                   │
-- ╰──────────────────────────────────────────────────────────╯
-- Start compilation
keymap.set("n", "<leader>lc", ":VimtexCompile<cr><cr>", { desc = "Start compilation" })

-- Jump in PDF to the current position in tex file
keymap.set("n", "<leader>lp", ":VimtexView<cr><cr>", { desc = "Jump in PDF to current position" })

-- Cleanup files
keymap.set("n", "<leader>lC", ":VimtexClean<cr><cr>", { desc = "Cleanup files" })

-- Toggle TOC
keymap.set("n", "<leader>lt", ":VimtexTocToggle<cr>", { desc = "Toggle TOC" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ NVIM Tree (File Explorer)                                │
-- ╰──────────────────────────────────────────────────────────╯
-- keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ LSP                                                      │
-- ╰──────────────────────────────────────────────────────────╯
-- lsp configs are defined in lua/plugins/lsp/lspconfig.lua

-- ╭──────────────────────────────────────────────────────────╮
-- │ Treesitter                                               │
-- ╰──────────────────────────────────────────────────────────╯
-- treesitter configs are defined in
-- lua/plugins/treesitter/nvim-treesitter-text-objects.lua

-- ╭──────────────────────────────────────────────────────────╮
-- │ Debugger                                                 │
-- ╰──────────────────────────────────────────────────────────╯
-- debugger configs are defined in lua/plugins/debugger/nvim-dap.lua

-- ╭──────────────────────────────────────────────────────────╮
-- │ Git                                                      │
-- ╰──────────────────────────────────────────────────────────╯
-- Open LazyGit
keymap.set("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "Open lazy git" })

-- Gitsigns
vim.keymap.set("n", "<leader>gh", function()
	vim.cmd("Gitsigns toggle_deleted")
	vim.cmd("Gitsigns toggle_linehl")
end, { desc = "Toggle show changes" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ Codeium                                                  │
-- ╰──────────────────────────────────────────────────────────╯
-- Codeium keybindings are defined in lua/plugins/codeium.lua
