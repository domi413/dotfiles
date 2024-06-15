return {
	"karb94/neoscroll.nvim",
	opts = {
		mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },

		-- Hide cursor while scrolling
		hide_cursor = true,

		-- Stop at <EOF> when scrolling downwards
		stop_eof = true,

		-- Stop scrolling when the cursor reaches the scrolloff margin of the file
		respect_scrolloff = true,

		-- The cursor will keep on scrolling even if the window cannot scroll further
		cursor_scrolls_alone = false,

		-- Default easing function
		easing_function = nil,

		-- Function to run before the scrolling animation starts
		pre_hook = nil,

		-- Function to run after the scrolling animation ends
		post_hook = nil,

		-- Disable "Performance Mode" on all buffers.
		performance_mode = false,
	},
	config = function(_, opts)
		require("neoscroll").setup(opts)

		local t = {}
		-- Syntax: t[keys] = {function, {function arguments}}
		t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "250" } }
		t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "250" } }
		t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "150" } }
		t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "150" } }
		t["<C-y>"] = { "scroll", { "-0.10", "false", "100" } }
		t["<C-e>"] = { "scroll", { "0.10", "false", "100" } }
		t["zt"] = { "zt", { "250" } }
		t["zz"] = { "zz", { "250" } }
		t["zb"] = { "zb", { "250" } }

		require("neoscroll.config").set_mappings(t)
	end,
}
