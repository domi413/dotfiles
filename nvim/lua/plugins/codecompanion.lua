return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		{
			"OXY2DEV/markview.nvim",
			lazy = false,
			opts = {
				preview = {
					filetypes = { "markdown", "codecompanion" },
					ignore_buftypes = {},
				},
			},
		},
	},

	config = function()
		require("codecompanion").setup({
			display = {
				chat = {
					window = {
						width = 0.4,
					},
				},
			},
			adapters = {
				copilot = function()
					return require("codecompanion.adapters").extend("copilot", {
						schema = {
							model = {
								default = "claude-sonnet-4",
							},
						},
					})
				end,
			},
			strategies = {
				chat = {
					adapter = "copilot",
				},
				inline = {
					adapter = "copilot",
				},
				cmd = {
					adapter = "copilot",
				},
			},
			opts = {
				system_prompt = function()
					return [[
                        You are an expert software engineer and coding assistant.
                        You provide accurate, helpful, and comprehensive responses.
                        When helping with code, focus on best practices, security, performance, and maintainability.
                        Always explain your reasoning and provide examples when appropriate.
                    ]]
				end,
			},
		})
	end,
}
