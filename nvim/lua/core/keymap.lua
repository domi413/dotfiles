-- ╭──────────────────────────────────────────────────────────╮
-- │ General configs                                          │
-- ╰──────────────────────────────────────────────────────────╯
-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

-- ╭──────────────────────────────────────────────────────────╮
-- │ Window tiling                                            │
-- ╰──────────────────────────────────────────────────────────╯
keymap.set("n", "<leader>sk", "<cmd>topleft split<CR>", { desc = "Split window up" })
keymap.set("n", "<leader>sj", "<cmd>split<CR>", { desc = "Split window down" })
keymap.set("n", "<leader>sl", "<cmd>vsplit<CR>", { desc = "Split window right" })
keymap.set("n", "<leader>sh", "<cmd>topleft vsplit<CR>", { desc = "Split window left" })
keymap.set("n", "<leader>sr", "<cmd>wincmd =<CR>", { desc = "Reset splitted window width / height" })
keymap.set("n", "<leader>x", "<cmd>bdelete!<CR>", { desc = "Close split/tab" })
-- keymap.set("n", "<leader>x", "<cmd>close<CR>", { desc = "Close split/tab" })

-- Resize splitted windows
keymap.set("n", "<leader>va", "<cmd>vertical resize +10<CR>", { desc = "Increase width of splitted window" })
keymap.set("n", "<leader>vx", "<cmd>vertical resize -10<CR>", { desc = "Decrease width of splitted window" })
keymap.set("n", "<leader>ha", "<cmd>resize +5<CR>", { desc = "Increase height of splitted window" })
keymap.set("n", "<leader>hx", "<cmd>resize -5<CR>", { desc = "Decrease height of splitted window" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ Buffer                                                   │
-- ╰──────────────────────────────────────────────────────────╯
-- Move buffer
keymap.set("n", "<Leader>>", "<cmd>BufferLineMoveNext<CR>", { desc = "Move buffer to right" })
keymap.set("n", "<Leader><", "<cmd>BufferLineMovePrev<CR>", { desc = "Move buffer to left" })

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
-- vim.keymap.set("n", "<Leader>>", "<cmd>tabmove +1<CR>", { desc = "Move tab to right" })
-- vim.keymap.set("n", "<Leader><", "<cmd>tabmove -1<CR>", { desc = "Move tab to left" })

-- Tab navigation
-- keymap.set("n", "<C-p>", "<cmd>tabn<CR>") -- Go to next tab
-- keymap.set("n", "<C-n>", "<cmd>tabp<CR>") -- To go previous tab

-- ╭──────────────────────────────────────────────────────────╮
-- │ Editing / Editor                                         │
-- ╰──────────────────────────────────────────────────────────╯
-- clear search highlights
keymap.set("n", "<leader>nh", "<cmd>nohl<CR>", { desc = "Clear search highlights" })

-- New Line (normal mode)
-- Insert a new line above/below without entering into insert-mode
keymap.set("n", "<leader>o", "o<Esc>", { desc = "Insert line above" })
keymap.set("n", "<leader>O", "O<Esc>", { desc = "Insert line below" })

-- Toggle case
keymap.set({ "n", "v", "s", "x" }, "<leader>i", "~", { desc = "Toggle case" })

-- Toggle line wrapping
keymap.set("n", "<leader>$", "<cmd>set wrap!<CR>", { desc = "Toggle line wrapping" })

-- Toggle outline
keymap.set("n", "<leader>to", "<cmd>Outline<CR>", { desc = "Toggle outline" })

-- Save file
keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })

-- Repeat last macro
keymap.set("n", "#", "@@", { desc = "Repeat last macro" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ Sessions                                                 │
-- ╰──────────────────────────────────────────────────────────╯
-- Search session
keymap.set("n", "<leader>fs", "<cmd>Telescope session-lens<CR>", { desc = "Search sessions" })

-- Save session
keymap.set("n", "<leader>ss", "<cmd>SessionSave<CR>", { desc = "Search sessions" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ Zen-Mode                                                 │
-- ╰──────────────────────────────────────────────────────────╯
keymap.set("n", "<leader>tz", "<cmd>ZenMode<CR>", { desc = "Toggle ZenMode" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ UndoTree                                                 │
-- ╰──────────────────────────────────────────────────────────╯
keymap.set("n", "<leader>tu", "<cmd>UndotreeToggle<CR>", { desc = "Toggle undoTree" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ Telescope                                                │
-- ╰──────────────────────────────────────────────────────────╯
-- Open fuzzy file finder
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Fuzzy find files in cwd" })

-- Open fuzzy content finder
keymap.set("n", "<leader>fc", "<cmd>Telescope live_grep<CR>", { desc = "Fuzzy find content in cwd" })

-- Change color scheme
keymap.set("n", "<leader>ft", "<cmd>Telescope colorscheme enable_preview=true<CR>", { desc = "Change theme" })

-- Open registers
keymap.set("n", "<leader>fr", "<cmd>Telescope registers<CR>", { desc = "Open registers" })

-- Open marks
keymap.set("n", "<leader>fm", "<cmd>Telescope marks<CR>", { desc = "Open marks" })

-- Browse TODO comments
keymap.set("n", "<leader>fg", "<cmd>TodoTelescope<CR>", { desc = "Browse TODO comments" })

-- Switch tabs
keymap.set("n", "<leader>st", "<cmd>Telescope buffers<CR>", { desc = "Switch buffer" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ Vimtex                                                   │
-- ╰──────────────────────────────────────────────────────────╯
-- Start compilation
keymap.set("n", "<leader>lc", "<cmd>w | VimtexCompile<CR><CR>", { desc = "Start compilation" })

-- Jump in PDF to the current position in tex file
keymap.set("n", "<leader>lp", "<cmd>VimtexView<CR>", { desc = "Jump in PDF to current position" })

-- Cleanup files
keymap.set("n", "<leader>lC", "<cmd>VimtexClean<CR><CR>", { desc = "Cleanup files" })

-- Toggle TOC
keymap.set("n", "<leader>lt", function()
	vim.cmd("VimtexTocToggle")
	vim.cmd("wincmd h")
end, { desc = "Toggle TOC" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ Toggle spellchecker                                      │
-- ╰──────────────────────────────────────────────────────────╯
keymap.set("n", "<leader>ts", "<cmd>set spell!<CR>", { desc = "Toggle spellchecker" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ NVIM Tree (File Explorer)                                │
-- ╰──────────────────────────────────────────────────────────╯
-- keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ LSP                                                      │
-- ╰──────────────────────────────────────────────────────────╯
-- lsp configs are defined in lua/plugins/lsp/lspconfig.lua

-- Toggle inlay hints
if vim.lsp.inlay_hint then
	keymap.set("n", "<leader>tt", function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
	end, { desc = "Toggle inlay hints" })
end

-- ╭──────────────────────────────────────────────────────────╮
-- │ Treesitter                                               │
-- ╰──────────────────────────────────────────────────────────╯
-- treesitter motions are defined in
-- lua/plugins/treesitter/nvim-treesitter-text-objects.lua

-- ╭──────────────────────────────────────────────────────────╮
-- │ Debugger                                                 │
-- ╰──────────────────────────────────────────────────────────╯
-- debugger configs are defined in lua/plugins/debugger/nvim-dap.lua

-- ╭──────────────────────────────────────────────────────────╮
-- │ Git                                                      │
-- ╰──────────────────────────────────────────────────────────╯
-- Open LazyGit
keymap.set("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = "Open lazy git" })

-- Gitsigns
vim.keymap.set("n", "<leader>gh", function()
	vim.cmd("Gitsigns toggle_deleted")
	vim.cmd("Gitsigns toggle_linehl")
end, { desc = "Toggle show changes" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ Codeium                                                  │
-- ╰──────────────────────────────────────────────────────────╯
-- Codeium keybindings are defined in lua/plugins/codeium.lua
