require("mason-tool-installer").setup({
	ensure_installed = {
		"bashls",
		"clang-format",
		"clangd",
		"cspell-lsp",
		"css-lsp",
		"gersemi",
		"golangci-lint-langserver",
		"gopls",
		"html-lsp",
		"lua_ls",
		"neocmakelsp",
		"prettier",
		"pyright",
		"ruff",
		"shellcheck",
		"shfmt",
		"stylua",
		"texlab",
		"typescript-language-server",
	},
})

local lspconfig = require("lspconfig")

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(args)
		local opts = { buffer = args.buf, silent = true }
		local keymap = vim.keymap

		opts.desc = "Show references"
		keymap.set("n", "grr", "<cmd>Telescope lsp_references<CR>", opts)

		opts.desc = "Go definition"
		keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

		opts.desc = "Go definition in new tab"
		keymap.set("n", "gD", "<cmd>tab split | Telescope lsp_definitions<CR>", opts)

		opts.desc = "Show diagnostics"
		keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

		opts.desc = "Go to previous diagnostic"
		keymap.set("n", "<leader>dp", function()
			vim.diagnostic.jump({ count = -1, float = false })
		end, opts)

		opts.desc = "Go to next diagnostic"
		keymap.set("n", "<leader>dn", function()
			vim.diagnostic.jump({ count = 1, float = false })
		end, opts)

		opts.desc = "Show documentation"
		keymap.set("n", "K", function()
			vim.lsp.buf.hover({ border = "rounded", max_width = 70 })
		end, opts)
	end,
})

local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
local signConf = { text = {}, texthl = {}, numhl = {} }

for type, icon in pairs(signs) do
	local severityName = string.upper(type)
	local severity = vim.diagnostic.severity[severityName]
	local hl = "DiagnosticSign" .. type
	signConf.text[severity] = icon
	signConf.texthl[severity] = hl
	signConf.numhl[severity] = hl
end

-- This disables the css color highlighting from the lsp
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function()
		vim.lsp.document_color.enable(false)
	end,
})

vim.diagnostic.config({
	signs = signConf,
})

lspconfig.clangd.setup({
	cmd = {
		"clangd",
		"--clang-tidy",
		"--background-index",
		"--inlay-hints=false",
	},
	filetypes = { "c", "cpp", "objc", "objcpp" },
	root_dir = require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
})
lspconfig.gopls.setup({
	settings = {
		gopls = {
			analyses = { unusedparams = true },
			gofumpt = true,
			hints = {
				assignVariableType = false,
				compositeLiteralFields = false,
				compositeLiteralTypes = false,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			staticcheck = true,
			usePlaceholders = true,
		},
	},
})
lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim", "require" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#E55353" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#E0B644" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = "#419BEF" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "#49B675" })

-----------------------------------------------------------
-- Toggling virtual lines
-----------------------------------------------------------
local diagnostic_states = { enabled = true, inline = true }

local diagnostic_configs = {
	inline = { virtual_text = { prefix = "●" }, virtual_lines = false },
	detailed = { virtual_text = false, virtual_lines = true },
	disabled = { virtual_text = false, virtual_lines = false },
}

local function get_active_config()
	if not diagnostic_states.enabled then
		return diagnostic_configs.disabled
	end
	return diagnostic_states.inline and diagnostic_configs.inline or diagnostic_configs.detailed
end

-- Apply the initial configuration
vim.diagnostic.config(get_active_config())

vim.keymap.set("n", "<Leader>tl", function()
	if diagnostic_states.enabled then
		diagnostic_states.inline = not diagnostic_states.inline
		vim.diagnostic.config(get_active_config())
	end
end, { desc = "Toggle detailed diagnostics" })

vim.keymap.set("n", "<Leader>td", function()
	diagnostic_states.enabled = not diagnostic_states.enabled
	vim.diagnostic.config(get_active_config())
end, { desc = "Toggle diagnostics" })
