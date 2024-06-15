-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

----------------------------------------
-- General Keymaps

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete character without copying into register
keymap.set("n", "x", '"_x')
keymap.set("n", "D", '"_D')
keymap.set("n", "dd", '"_dd')
keymap.set("n", "dw", '"_dw')
keymap.set("n", "d$", '"_d$')
keymap.set("n", "d^", '"_d^')
keymap.set("n", "db", '"_db')
keymap.set("n", "diw", '"_diw')
keymap.set("n", "daw", '"_daw')
keymap.set("n", 'di"', '"_di"')
keymap.set("n", 'da"', '"_da"')
keymap.set("n", "di'", "\"_di'")
keymap.set("n", "da'", "\"_da'")
keymap.set("n", "di(", '"_di(')
keymap.set("n", "da(", '"_da(')
keymap.set("n", "di)", '"_di)')
keymap.set("n", "da)", '"_da)')
keymap.set("n", "di}", '"_di}')
keymap.set("n", "d%", '"_d%')
keymap.set("n", 'dt"', '"_dt"')
-- Visual mode delete
keymap.set("v", "d", '"_d')
keymap.set("v", "x", '"_x')
-- Visual line mode
keymap.set("x", "d", '"_d')
keymap.set("x", "x", '"_x')
-- Visual block delete
keymap.set("s", "d", '"_d')
keymap.set("s", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>sr", "<C-w>=", { desc = "Reset splitted window width / height" })
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close current splitted window" })

-- Resize window shortcuts
keymap.set("n", "<leader>v+", ":vertical resize +10<CR>", { desc = "Increase width of splitted window" })
keymap.set("n", "<leader>v-", ":vertical resize -10<CR>", { desc = "Decrease width of splitted window" })
keymap.set("n", "<leader>h+", ":resize +5<CR>", { desc = "Increase height of splitted window" })
keymap.set("n", "<leader>h-", ":resize -5<CR>", { desc = "Decrease height of splitted window" })

-- Tab management
keymap.set("n", "<leader>nt", ":tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>ct", ":tabclose<CR>", { desc = "Close tab" })
keymap.set("n", "<Tab>", ":tabn<CR>")
keymap.set("n", "<S-Tab>", ":tabp<CR>")

-- Indent management
keymap.set("i", "<S-Tab>", "<C-d>") -- for insert mode

-- New Line (normal mode)
keymap.set("n", "<leader>o", "o<Esc>", { noremap = true, silent = true, desc = "Insert line above" })
keymap.set("n", "<leader>O", "O<Esc>", { noremap = true, silent = true, desc = "Insert line below" })

-- restart lsp server
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- Toggle case
keymap.set("n", "<leader>i", "~", { desc = "Toggle case" })

-- Remap 'gx' to open links in the browser
keymap.set("n", "gx", ":!open <cWORD><CR><CR>", { desc = "Open URL under cursor" })

-- Toggle line wrapping
keymap.set("n", "<leader>$", ":set wrap!<CR>", { desc = "Toggle line wrapping" })

-- Save file
keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })

-- Paste from clipboard
keymap.set("n", "<leader>p", "0p", { desc = "Paste from clipboard" })

-- Telescope
keymap.set("n", "<space>fe", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = "File Browser" })
keymap.set("n", "<space>fe", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = "File Browser" })
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
keymap.set(
	"n",
	"<leader>ft",
	"<cmd>Telescope colorscheme enable_preview=true<cr>",
	{ noremap = true, silent = true, desc = "Change theme" }
)
