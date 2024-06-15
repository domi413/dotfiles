return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		local banners = {
			["nvchad"] = {
				"           ▄ ▄                   ",
				"       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
				"       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
				"    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
				"  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
				"  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
				"▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
				"█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
				"    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
			},
			["hydra"] = {
				"                                   ",
				"                                   ",
				"                                   ",
				"   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
				"    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
				"          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
				"           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
				"          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
				"   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
				"  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
				" ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
				" ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
				"      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
				"       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
				"                                   ",
			},
			["neovim"] = {
				" ███       ███ ",
				"████      ████",
				"██████     █████",
				"███████    █████",
				"████████   █████",
				"█████████  █████",
				"█████ ████ █████",
				"█████  █████████",
				"█████   ████████",
				"█████    ███████",
				"█████     ██████",
				"████      ████",
				" ███       ███ ",
				"                  ",
				" N  E  O  V  I  M ",
			},
		}

		-- Function to get a random banner
		-- local function get_random_banner()
		-- 	local keys = vim.tbl_keys(banners)
		-- 	local random_key = keys[math.random(1, #keys)]
		-- 	return banners[random_key]
		-- end

		-- select theme
		dashboard.section.header.val = banners["neovim"]

		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
			-- TODO: Open recent

			dashboard.button("SPC fe", "  > File Explorer", "<cmd>Telescope file_browser<CR>"),
			dashboard.button("SPC ff", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
			dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
		}

		-- footer
		local function file_exists(file)
			local f = io.open(file, "rb")
			if f then
				f:close()
			end
			return f ~= nil
		end

		local function line_from(file)
			if not file_exists(file) then
				return {}
			end
			local lines = {}
			for line in io.lines(file) do
				lines[#lines + 1] = line
			end
			return lines
		end

		local function footer()
			local plugins = require("lazy").stats().count
			local v = vim.version()
			local config_dir = vim.fn.stdpath("config")
			local elapsed_time = (vim.loop.hrtime() - _G.start_time) / 1e6
			return string.format(
				" v%d.%d.%d  󰂖 %d plugins  󰔛 %.2f ms",
				v.major,
				v.minor,
				v.patch,
				plugins,
				elapsed_time
			)
		end

		dashboard.section.footer.val = {
			footer(),
		}
		dashboard.section.footer.opts = {
			position = "center",
			hl = "EcovimFooter",
		}

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
