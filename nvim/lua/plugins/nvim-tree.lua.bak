return {
	"nvim-tree/nvim-tree.lua",
	-- dependencies = { "nvim-tree/nvim-web-devicons" },
	dependencies = { "DaikyXendo/nvim-material-icon" },
	config = function()
		-- change color for arrows in tree to light blue
		vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
		vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

		-- configure nvim-tree
		require("nvim-tree").setup({
			view = {
				width = 40,
				side = "left",
				relativenumber = true,
			},
			filters = {
				dotfiles = true, -- This will hide dotfiles
			},
		})
	end,
}
