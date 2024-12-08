return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		"L3MON4D3/LuaSnip", -- snippet engine
		-- "saadparwaiz1/cmp_luasnip", -- for autocompletion
		-- "rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim", -- vs-code like pictograms
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		require("luasnip.loaders.from_vscode").lazy_load()

		-- Set amount of completion items to show
		vim.opt.pumheight = 10

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
				fields = { "abbr", "kind", "menu" }, -- Add this line to specify required fields
				format = lspkind.cmp_format({
					mode = "symbol_text",
					maxwidth = {
						menu = 15,
						abbr = 15,
					},
					ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
				}),
			},
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-j>"] = cmp.mapping(function(fallback)
					-- ["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-k>"] = cmp.mapping(function(fallback)
					-- ["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end, { "i", "s" }),

				-- go to next snippet
				["<C-l>"] = cmp.mapping(function(fallback)
					if luasnip.jumpable(1) then
						luasnip.jump(1)
					else
						fallback()
					end
				end, { "i", "s" }),

				-- go to previous snippet
				["<C-h>"] = cmp.mapping(function(fallback)
					if luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),

				["<CR>"] = cmp.mapping.confirm({ select = false }), -- Enter to confirm the selection
			}),

			-- Mapping to close the completion window with Esc in insert mode
			-- ["<Esc>"] = cmp.mapping(function(fallback)
			-- 	if cmp.visible() then
			-- 		cmp.abort()
			-- 	else
			-- 		fallback()
			-- 	end
			-- end, { "i", "s" }),
			-- sources for autocompletion

			-- Sources for the autocompletion
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- snippets
				-- { name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			}),
		})
	end,
}
