return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			ensure_installed = {
				"bashls",
				"clangd",
				"gopls",
				"lua_ls",
				"pyright",
				"texlab",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"clang-format",
				"css-lsp",
				"cspell",
				"html-lsp",
				"prettier",
				"ruff",
				"shellcheck",
				"shfmt",
				"stylua",
				"typescript-language-server",
			},
		})
	end,
}
