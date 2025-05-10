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
-- │ Sessions                                                 │
-- ╰──────────────────────────────────────────────────────────╯
-- Search session
keymap.set("n", "<leader>fs", "<cmd>Telescope session-lens<cr>", { desc = "Search sessions" })

-- Save session
keymap.set("n", "<leader>ss", "<cmd>SessionSave<cr>", { desc = "Search sessions" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ Zen-Mode                                                 │
-- ╰──────────────────────────────────────────────────────────╯
keymap.set("n", "<leader>tz", "<cmd>ZenMode<cr>", { desc = "Toggle ZenMode" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ UndoTree                                                 │
-- ╰──────────────────────────────────────────────────────────╯
keymap.set("n", "<leader>tu", "<cmd>UndotreeToggle<cr>", { desc = "Toggle undoTree" })

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
-- │ Vimtex                                                   │
-- ╰──────────────────────────────────────────────────────────╯
-- Start compilation
keymap.set("n", "<leader>lc", "<cmd>w | VimtexCompile<cr><cr>", { desc = "Start compilation" })

-- Jump in PDF to the current position in tex file
keymap.set("n", "<leader>lp", "<cmd>VimtexView<cr><cr>", { desc = "Jump in PDF to current position" })

-- Cleanup files
keymap.set("n", "<leader>lC", "<cmd>VimtexClean<cr><cr>", { desc = "Cleanup files" })

-- Toggle TOC
keymap.set("n", "<leader>lt", function()
	vim.cmd("VimtexTocToggle")
	vim.cmd("wincmd h")
end, { desc = "Toggle TOC" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ Toggle spellchecker                                      │
-- ╰──────────────────────────────────────────────────────────╯
keymap.set("n", "<leader>ts", "<cmd>set spell!<cr>", { desc = "Toggle spellchecker" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ CodeCompanion (AI assistant)                             │
-- ╰──────────────────────────────────────────────────────────╯
-- Toggle assistant panel
keymap.set(
	{ "n", "v", "s", "x" },
	"<leader>cc",
	":<C-u>'<,'>CodeCompanionChat<cr>",
	{ desc = "Toggle assistant panel" }
)

-- Call inline assistant
keymap.set({ "n", "v", "s", "x" }, "<leader>ca", ":<C-u>'<,'>CodeCompanion<cr>", { desc = "Toggle inline assistant" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ NVIM Tree (File Explorer)                                │
-- ╰──────────────────────────────────────────────────────────╯
-- keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })

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
