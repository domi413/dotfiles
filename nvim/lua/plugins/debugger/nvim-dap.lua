return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui", -- UI for nvim-dap
		"theHamsta/nvim-dap-virtual-text", -- Inlines the values for variables as virtual text
		"nvim-neotest/nvim-nio",

		-- Debug-adapter per filetype
		"mfussenegger/nvim-dap-python",
		"leoluz/nvim-dap-go",
		"nicholasmata/nvim-dap-cs",
	},

	config = function()
		-- Breakpoint highlighting
		local dap = require("dap")
		local dapui = require("dapui")

		require("nvim-dap-virtual-text").setup({
			enabled = true,
			highlight_changed_variables = true,
			virt_text_pos = "eol", -- use inline or eol
			all_frames = true,
		})

		require("dapui").setup()
		require("dap-go").setup()
		require("dap-python").setup()
		-- TODO: C/C++ debugger
		-- TODO: java debugger
		require("dap-cs").setup()

		require("nvim-treesitter.install").update({ with_sync = true })

		-- Breakpoint color
		vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError" })

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "[DEBUG] Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>dr", dap.continue, { desc = "[DEBUG] Start / Continue" })
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "[DEBUG] Step into" })
		vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "[DEBUG] Step over" })
		vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "[DEBUG] Step out" })
		vim.keymap.set("n", "<leader>dC", dap.clear_breakpoints, { desc = "[DEBUG] Clear all Breakpoints" })
		vim.keymap.set("n", "<leader>dx", function()
			dap.terminate()
			dapui.close()
		end, { desc = "[DEBUG] Terminate" })
	end,
}
