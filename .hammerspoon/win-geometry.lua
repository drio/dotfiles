local M = {}

local common = require("common")

local display_monitor
local layoutMiddleAB = {
	{ "Brave Browser", nil, display_monitor, hs.geometry.unitrect(0, 0, 0.5, 1), nil, nil },
	{ "Alacritty", nil, display_monitor, hs.geometry.unitrect(0.5, 0, 0.5, 1), nil, nil },
}
local layoutFullAB = {
	{ "Brave Browser", nil, display_monitor, hs.geometry.unitrect(0, 0, 1, 1), nil, nil },
	{ "Alacritty", nil, display_monitor, hs.geometry.unitrect(0, 0, 1, 1), nil, nil },
}

local setCorrectAMLayout = function()
	local wins = hs.window.allWindows()
	local l = {
		{ "Activity Monitor", nil, common.screens.retina, hs.geometry.unitrect(0, 0, 0.5, 0.5), nil, nil },
	}
	for _, w in pairs(wins) do
		local app = w:application()
		local name = app:name()
		if name == "Activity Monitor" then
			l[1][2] = w
			if string.find(tostring(w), "Activity Monitor") then
				l[1][4] = hs.geometry.unitrect(0, 0, 0.5, 1)
			end
			if string.find(tostring(w), "CPU History") then
				l[1][4] = hs.geometry.unitrect(0.58, 0, 0.42, 0.55)
			end
			if string.find(tostring(w), "GPU History") then
				l[1][4] = hs.geometry.unitrect(0.58, 0.55, 0.42, 0.25)
			end
			if string.find(tostring(w), "CPU Usage") then
				l[1][4] = hs.geometry.unitrect(0.58, 0.80, 0.4, 0.25)
			end
			hs.layout.apply(l)
		end
	end
end

M.Load = function(hyper)
	local hyperfns = {}
	hyperfns["h"] = function()
		hs.layout.apply(layoutMiddleAB)
	end
	hyperfns["return"] = function()
		hs.layout.apply(layoutFullAB)
	end
	hyperfns["7"] = function()
		setCorrectAMLayout()
	end

	for _hotkey, _fn in pairs(hyperfns) do
		hs.hotkey.bind(hyper, _hotkey, _fn)
	end
end

return M
