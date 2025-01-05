-- return {
-- 	"ggandor/leap.nvim",
-- 	config = function()
-- 		local leap = require("leap")
--
-- 		leap.create_default_mappings()
--
-- 		vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
--
-- 		leap.opts.preview_filter = function()
-- 			return false
-- 		end
-- 	end,
-- }
return {
	"ggandor/flit.nvim",
	dependencies = {
		"ggandor/leap.nvim",
	},

	config = function()
		require("flit").setup({
			keys = { f = "f", F = "F", t = "t", T = "T" },
			-- A string like "nv", "nvo", "o", etc.
			labeled_modes = "v",
			-- Repeat with the trigger key itself.
			clever_repeat = true,
			multiline = true,
			-- Like `leap`s similar argument (call-specific overrides).
			-- E.g.: opts = { equivalence_classes = {} }
			opts = {},
		})
	end,
}
