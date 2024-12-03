-- Plugins
require("relative-motions"):setup({
	show_numbers = "relative",
	show_motion = true,
})
require("full-border"):setup({
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.ROUNDED,
})
require("git"):setup()
require("starship"):setup()

-- custom functions
-- function Linemode:file_info()
-- 	-- Get time of last modification
-- 	local time = math.floor(self._file.cha.modified or 0)
-- 	if time == 0 then
-- 		time = ""
-- 	elseif os.date("%Y", time) == os.date("%Y") then
-- 		time = os.date("%b %d %H:%M", time)
-- 	else
-- 		time = os.date("%b %d  %Y", time)
-- 	end
--
-- 	-- Get file size or amount of file inside folder
-- 	local size = self._file:size()
-- 	if size then
-- 		size = ya.readable_size(size)
-- 	else
-- 		local folder = cx.active:history(self._file.url)
-- 		size = folder and tostring(#folder.files) or ""
-- 	end
--
-- 	-- Get file permissions
-- 	local permissions = self._file.cha:perm() or ""
--
-- 	return ui.Line(string.format("%s   %s   %s", permissions, size, time))
-- end
-- function Linemode:file_info()
-- 	return ui.Line("%s   %s   %s", self:permissions(), self:size(), self:mtime())
-- end
