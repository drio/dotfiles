local module = {}

local battery = require("battery")
local drdWindows = require("windows")
local drdKeyboard = require("keyboard")
local common = require("common")
local tsb = common.tsb

-- Use: osascript -e 'id of app "SQLDeveloper"' to get app ID
local keys = {
	{ key = "0", name = "OBS" },
	{ key = "a", name = "Alacritty" },
	{ key = "b", name = "Brave Browser" },
	{ key = "c", name = "Calendar" },
	{ key = "d", name = "Bitwarden" },
	{ key = "e", name = "Firefox Developer Edition" },
	{ key = "f", name = "Finder" },
	--{ key = "g", name = "Telegram" },
	{ key = "h", name = "Google Chrome" },
	{ key = "i", name = "Signal" },
	--{ key = "j", name = "Joplin" },
	{ key = "k", name = "Slack" },
	--{key = 'l', name = 'Spotlight'},
	{ key = "m", name = "Mail" },
	{ key = "n", name = "Notes" },
	--{ key = "o", name = "Obsidian" },
	{ key = "p", name = "mpv" },
	--{key = 'q', name = 'mpv'},
	{ key = "r", name = "Preview" },
	{ key = "s", name = "Safari" },
	--{ key = "u", name = "TablePlus" },
	{ key = "v", id = "com.apple.ActivityMonitor" },
	{ key = "w", name = "NetNewsWire" },
	{ key = "y", id = "com.apple.systempreferences" },
	{ key = "z", id = "com.apple.reminders" },
	{ key = "7", name = "Discord" },
}

-- for _, v in ipairs(hsapp_list) do
-- 	if v.id then
-- 		local located_name = hs.application.nameForBundleID(v.id)
-- 		if located_name then
-- 			modal:bind("", v.key, located_name, function()
-- 				hs.application.launchOrFocusByBundleID(v.id)
-- 				spoon.ModalMgr:deactivate({ "appM" })
-- 			end)
-- 		end
-- 	elseif v.name then
-- 		modal:bind("", v.key, v.name, function()
-- 			hs.application.launchOrFocus(v.name)
-- 			spoon.ModalMgr:deactivate({ "appM" })
-- 		end)
-- 	end
-- end

module.Load = function(hyper)
	-- App launcher
	spoon.ModalMgr.supervisor:bind(hyper, "space", "Enter AppM Environment", function()
		spoon.ModalMgr:deactivateAll()
		spoon.ModalMgr:activate({ "appM" }, "#FFBD2E", false)
	end)

	spoon.ModalMgr:new("appM")
	local modal = spoon.ModalMgr.modal_list["appM"]
	modal:bind("", "escape", "Deactivate appM", function()
		spoon.ModalMgr:deactivate({ "appM" })
	end)
	modal:bind("", "Q", "Deactivate appM", function()
		spoon.ModalMgr:deactivate({ "appM" })
	end)
	modal:bind("", "tab", "Toggle Cheatsheet", function()
		spoon.ModalMgr:toggleCheatsheet()
	end)

	common.setKeys(keys, modal)
end

return module
