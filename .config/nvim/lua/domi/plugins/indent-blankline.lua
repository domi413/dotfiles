return {
	-- TODO: How to show the . between the indentation
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	config = function()
		require("ibl").setup({
			enabled = true, -- Disables the plugin
			indent = {
				-- char = "│",
				char = ".",
				smart_indent_cap = false,
			},
			exclude = {
				filetypes = { "help", "packer" }, -- Example to exclude certain filetypes
			},
			scope = {
				enabled = false, -- Disable scope highlighting
			},
		})
	end,
}
