-- ╭──────────────────────────────────────────────────────────╮
-- │ CMake                                                    │
-- ╰──────────────────────────────────────────────────────────╯

local keymap = vim.keymap

keymap.set("n", "<leader><leader>mc", ":CMakeGenerate<CR>", { desc = "CMake Configure" })
keymap.set("n", "<leader><leader>mC", ":CMakeGenerate!<CR>", { desc = "CMake Configure Clean" })
keymap.set("n", "<leader><leader>mb", ":CMakeBuild<CR>", { desc = "CMake Build" })
keymap.set("n", "<leader><leader>mB", ":CMakeBuild!<CR>", { desc = "CMake Build Clean" })
keymap.set("n", "<leader><leader>mf", ":CMakeBuildCurrentFile<CR>", { desc = "CMake Build Current File" })
keymap.set("n", "<leader><leader>mr", ":CMakeRun<CR>", { desc = "CMake Run" })
keymap.set("n", "<leader><leader>mR", ":CMakeRunCurrentFile<CR>", { desc = "CMake Run Current File" })
keymap.set("n", "<leader><leader>md", ":CMakeDebug<CR>", { desc = "CMake Debug" })
keymap.set("n", "<leader><leader>mD", ":CMakeDebugCurrentFile<CR>", { desc = "CMake Debug Current File" })
keymap.set("n", "<leader><leader>mt", ":CMakeRunTest<CR>", { desc = "CMake Run Tests" })
keymap.set("n", "<leader><leader>mx", ":CMakeClean<CR>", { desc = "CMake Clean" })
keymap.set("n", "<leader><leader>mi", ":CMakeInstall<CR>", { desc = "CMake Install" })
keymap.set("n", "<leader><leader>mq", ":CMakeQuickBuild<CR>", { desc = "CMake Quick Build" })
keymap.set("n", "<leader><leader>mQ", ":CMakeQuickRun<CR>", { desc = "CMake Quick Run" })
keymap.set("n", "<leader><leader>mZ", ":CMakeQuickDebug<CR>", { desc = "CMake Quick Debug" })
keymap.set("n", "<leader><leader>ms", ":CMakeSettings<CR>", { desc = "CMake Settings" })
keymap.set("n", "<leader><leader>mT", ":CMakeTargetSettings<CR>", { desc = "CMake Target Settings" })
