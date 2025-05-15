-- Plugins
require("relative-motions"):setup({
	show_numbers = "relative",
	show_motion = true,
})
require("full-border"):setup({ type = ui.Border.ROUNDED })
require("git"):setup()
require("starship"):setup({})

Linemode = Linemode or {}

function Linemode:rtime()
	local mtime = math.floor(self._file.cha.mtime or 0)
	if mtime == 0 then
		return "  --"
	end

	local now = os.time()
	local now_t = os.date("*t", now) --[[@as osdate]]
	local mtime_t = os.date("*t", mtime) --[[@as osdate]]

	local today_start_t = {
		year = now_t.year,
		month = now_t.month,
		day = now_t.day,
		hour = 0,
		min = 0,
		sec = 0,
	}
	local today_start = os.time(today_start_t)
	local yesterday_start = today_start - 86400

	local time_str = os.date("%H:%M", mtime) --[[@as string]]

	if mtime >= today_start then
		return string.format("  Today %s", time_str)
	elseif mtime >= yesterday_start then
		return string.format("  Yesterday %s", time_str)
	elseif now_t.year == mtime_t.year then
		local formatted = os.date("%d %b %H:%M", mtime) --[[@as string]]
		local result = string.gsub(formatted, "^0(%d)", "%1")
		if tonumber(result:match("^%d+")) <= 9 then
			return "   " .. result
		end
		return "  " .. result
	else
		local formatted = os.date("%d %b %Y", mtime) --[[@as string]]
		local result = string.gsub(formatted, "^0(%d)", "%1")
		if tonumber(result:match("^%d+")) <= 9 then
			return "   " .. result
		end
		return "  " .. result
	end
end
