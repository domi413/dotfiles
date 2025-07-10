return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "hrsh7th/cmp-nvim-lsp" },

	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(args)
				local opts = { buffer = args.buf, silent = true }
				local keymap = vim.keymap

				opts.desc = "Show references"
				keymap.set("n", "grr", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go definition"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

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

		local capabilities = cmp_nvim_lsp.default_capabilities()

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		mason_lspconfig.setup({
			handlers = {
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,
				["clangd"] = function()
					lspconfig["clangd"].setup({
						capabilities = capabilities,
						cmd = {
							"clangd",
							"--clang-tidy",
							"--background-index",
							"--inlay-hints=false",
						},
						filetypes = { "c", "cpp", "objc", "objcpp" },
						root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
					})
				end,
				["gopls"] = function()
					lspconfig["gopls"].setup({
						capabilities = capabilities,
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
				end,
				["lua_ls"] = function()
					lspconfig["lua_ls"].setup({
						capabilities = capabilities,
					})
				end,
			},
		})
	end,
}
