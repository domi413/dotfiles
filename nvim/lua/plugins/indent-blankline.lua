return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	---@module "ibl"
	---@type ibl.config
	opts = {
		-- debounce = 100, -- refresh interval, default: 200
		scope = { enabled = false, },
		indent = { smart_indent_cap = false, },
	},
}
