return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		"hrsh7th/cmp-cmdline", -- source for cmdline completions
		-- "hrsh7th/cmp-nvim-lsp-signature-help", -- Doens't work well
		"L3MON4D3/LuaSnip", -- snippet engine
		"onsails/lspkind.nvim", -- vs-code like pictograms
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		require("luasnip.loaders.from_vscode").lazy_load()

		-- Set amount of completion items to show
		vim.opt.pumheight = 10

		-- Insert mode completion
		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			window = {
				completion = {
					border = "rounded",
					winhighlight = "NormalFloat:FloatBorder,CursorLine:Visual,Search:None",
					col_offset = -3,
					side_padding = 1,
					scrollbar = false,
				},
				documentation = {
					border = "rounded",
					scrollbar = false,
					winhighlight = "NormalFloat:FloatBorder,CursorLine:Visual,Search:None",
				},
			},
			formatting = {
				expandable_indicator = true,
				fields = { "abbr", "kind", "menu" }, -- Specify required fields
				format = lspkind.cmp_format({
					mode = "symbol_text",
					maxwidth = {
						menu = 25,
						abbr = 25,
					},
					ellipsis_char = "...", -- Show dots when abbreviations are too long
				}),
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-j>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-k>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-l>"] = cmp.mapping(function(fallback)
					if luasnip.jumpable(1) then
						luasnip.jump(1)
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-h>"] = cmp.mapping(function(fallback)
					if luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			}),

			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- snippets
				{ name = "path" }, -- file system paths
				{ name = "nvim_lsp_signature_help" },
			}, {
				-- You can still add buffer source here for insert mode if needed
				{ name = "buffer", keyword_length = 3 },
			}),
		})

		-- Command-line setup here
		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline({
				["<C-j>"] = { c = cmp.mapping.select_next_item() },
				["<C-k>"] = { c = cmp.mapping.select_prev_item() },
			}),
			sources = {
				{ name = "buffer" },
			},
		})
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline({
				["<C-j>"] = {
					c = function(fallback)
						if vim.fn.getcmdline() == "" then
							cmp.mapping.select_prev_item()(fallback)
						else
							cmp.mapping.select_next_item()(fallback)
						end
					end,
				},
				["<C-k>"] = {
					c = function(fallback)
						if vim.fn.getcmdline() == "" then
							cmp.mapping.select_next_item()(fallback)
						else
							cmp.mapping.select_prev_item()(fallback)
						end
					end,
				},
				["<C-p>"] = {
					c = function(fallback)
						if vim.fn.getcmdline() == "" then
							cmp.mapping.select_prev_item()(fallback)
						else
							fallback()
						end
					end,
				},
				["<C-n>"] = {
					c = function(fallback)
						if vim.fn.getcmdline() == "" then
							cmp.mapping.select_next_item()(fallback)
						else
							fallback()
						end
					end,
				},
			}),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})
	end,
}
