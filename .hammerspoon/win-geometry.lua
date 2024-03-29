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

local layoutAlaSideBySide = function(screen)
	local wins = hs.window.allWindows()
	local l = {
		{ "Alacritty", nil, screen, nil, nil, nil },
	}
	local i = 1
	for _, w in pairs(wins) do
		local app = w:application()
		local name = app:name()
		if name == "Alacritty" then
			l[1][2] = w
			if i == 1 then
				l[1][4] = hs.geometry.unitrect(0, 0, 0.5, 1)
				i = i + 1
			else
				l[1][4] = hs.geometry.unitrect(0.5, 0, 0.5, 1)
			end
			hs.layout.apply(l)
			w:application():activate(true)
			w:application():unhide()
			w:focus()
		end
	end
end

local setCorrectAMLayout = function(screen)
	local wins = hs.window.allWindows()
	local l = {
		{ "Activity Monitor", nil, screen, nil, nil, nil },
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
			w:application():activate(true)
			w:application():unhide()
			w:focus()
		end
	end
end

M.Load = function(hyper)
	local hyperfns = {}
	hyperfns["h"] = function()
		hs.layout.apply(layoutMiddleAB)
		local wins = hs.window.allWindows()
		for _, w in pairs(wins) do
			local app = w:application()
			local name = app:name()
			if name == "Brave Browser" or name == "Alacritty" then
				w:application():activate(true)
				w:application():unhide()
				w:focus()
			end
		end
	end
	hyperfns["return"] = function()
		hs.layout.apply(layoutFullAB)
	end
	hyperfns["7"] = function()
		setCorrectAMLayout(common.screens.retina)
	end
	hyperfns["8"] = function()
		setCorrectAMLayout(common.screens.LG)
	end
	hyperfns["9"] = function() -- terminal one
		layoutAlaSideBySide(hs.screen.mainScreen())
	end
	hyperfns["n"] = function()
		layoutAlaSideBySide(common.screens.LG)
	end

	for _hotkey, _fn in pairs(hyperfns) do
		hs.hotkey.bind(hyper, _hotkey, _fn)
	end
end

return M
