-- ╭──────────────────────────────────────────────────────────╮
-- │ Code action                                              │
-- ╰──────────────────────────────────────────────────────────╯
-- Every code execute shorcut works like this:
-- <leader> + <leader> + ([r]un / [b]build)

-- Function to execute a command in current file dir
local function current_file_dir(term_command)
	-- Save the current directory
	local original_dir = vim.fn.getcwd()

	-- Change to the directory of the current file
	local file_path = vim.fn.expand("%:p:h")
	vim.cmd("lcd " .. file_path)

	-- Execute the command
	-- If you want to split the output vertically, change
	-- 'split | term' to 'vert term'
	vim.cmd("split | term " .. term_command)

	-- Reset to the original directory
	vim.cmd("lcd " .. original_dir)
end

-- Function to execute a command based on the filetype and action
local function action_by_filetype(action)
	local filetype = vim.bo.filetype -- Get filetype
	local file = vim.fn.expand("%:p") -- Get full path
	local file_title = vim.fn.expand("%:t") -- Get file name with extension
	local output = vim.fn.expand("%:t:r") .. ".out" -- Name for compiled output

	-- Save file first
	vim.cmd("w")

	-- Bash
	if filetype == "sh" and action == "run" then
		vim.cmd("silent !chmod +x " .. file)
		current_file_dir("bash " .. file)

	-- C
	elseif filetype == "c" then
		if action == "run" then
			current_file_dir("clang -O2 -std=c23 " .. file_title .. " -o " .. output .. " -lm" .. " && ./" .. output)
		elseif action == "compile" then
			current_file_dir("clang -O2 -std=c23 " .. file_title .. " -o " .. output)
		end

	-- C++
	elseif filetype == "cpp" then
		if action == "run" then
			current_file_dir("clang++ -O2 -std=c++23 " .. file_title .. " -o " .. output .. " && ./" .. output)
		elseif action == "compile" then
			current_file_dir("clang++ -O2 -std=c++23 " .. file_title .. " -o " .. output)
		end

	-- C#
	elseif filetype == "cs" then
		if action == "run" then
			current_file_dir("dotnet run")
		elseif action == "compile" then
			current_file_dir("dotnet build")
		end

	-- Go
	elseif filetype == "go" then
		if action == "run" then
			current_file_dir("go run " .. file)
		elseif action == "compile" then
			current_file_dir("go build -o " .. output .. " " .. file)
		end

	-- Java
	elseif filetype == "java" then
		if action == "run" then
			current_file_dir("javac " .. file_title .. " && java " .. vim.fn.expand("%:t:r"))
		elseif action == "compile" then
			current_file_dir("javac " .. file_title)
		end

	-- JavaScript / TypeScript
	elseif (filetype == "javascript" or filetype == "typescript") and action == "run" then
		current_file_dir("node " .. file)

	-- Lua
	elseif filetype == "lua" and action == "run" then
		current_file_dir("lua " .. file)

	-- Python
	elseif filetype == "python" and action == "run" then
		current_file_dir("python3 " .. file)

	-- ...
	else
		vim.api.nvim_echo({ { "Action not supported for this filetype", "ErrorMsg" } }, false, {})
	end
end

-- Create user commands for running and compiling
local command = vim.api.nvim_create_user_command
command("RunCode", function()
	action_by_filetype("run")
end, {})
command("CompileCode", function()
	action_by_filetype("compile")
end, {})

-- Key mappings to trigger the commands
vim.keymap.set("n", "<leader><leader>r", ":RunCode<CR>", { desc = "Run Code" })
vim.keymap.set("n", "<leader><leader>c", ":CompileCode<CR>", { desc = "Compile Code" })
