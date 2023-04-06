--[[
Useful references:
  - https://github.com/zzamboni/dot-hammerspoon
  - https://github.com/jhkuperus/dotfiles/blob/master/hammerspoon/init.lua
  - https://github.com/cmsj/hammerspoon-config/blob/master/init.lua
  - https://github.com/quickdraw6906/hammerspoon-pc
  - https://wiki.nikitavoloboev.xyz/macos/macos-apps/hammerspoon
--]]

-- Required to use with the cli tool: /Applications/Hammerspoon.app/Contents/Frameworks/hs/hs
require("hs.ipc")
require("cli")
local battery = require("battery")
local drdWindows = require("windows")
local drdKeyboard = require("keyboard")

hs.hotkey.alertDuration = 0
hs.hints.showTitleThresh = 0
hs.window.animationDuration = 0

hs.loadSpoon("SpoonInstall")
hs.loadSpoon("ModalMgr")
hs.loadSpoon("WinWin")
hs.loadSpoon("CountDown")

spoon.SpoonInstall.use_syncinstall = true
local Install = spoon.SpoonInstall

local hyper = { "cmd", "alt", "ctrl" }
local tsb = "/Applications/Tailscale.app/Contents/MacOS/Tailscale "
----------------
-- CMDS modal (T) --
----------------
local modalTS = "cmds ts"
spoon.ModalMgr.supervisor:bind(hyper, "i", "Enter ts Environment", function()
	spoon.ModalMgr:deactivateAll()
	spoon.ModalMgr:activate({ modalTS }, "#FF1493", false)
end)

spoon.ModalMgr:new(modalTS)
local cmds_cmodal = spoon.ModalMgr.modal_list[modalTS]
cmds_cmodal:bind("", "escape", "Deactivate modal TS", function()
	spoon.ModalMgr:deactivate({ "cmds" })
end)
cmds_cmodal:bind("", "Q", "Deactivate modal TS", function()
	spoon.ModalMgr:deactivate({ "cmds" })
end)
cmds_cmodal:bind("", "tab", "Toggle Cheatsheet TS", function()
	spoon.ModalMgr:toggleCheatsheet()
end)

local cmds_list = {
	{
		key = "b",
		show = "🚀 🫧",
		msg = "🚀 🫧 tailscale up (bubbles)",
		--cmd = tsb .. "switch tufts;" .. tsb .. "up --exit-node=100.104.24.6",
		cmd = tsb .. " up --exit-node=bubbles --exit-node-allow-lan-access",
	},

	{
		key = "d",
		show = "TS ⬇️",
		msg = "TS ⬇️  tailscale down",
		cmd = tsb .. " down",
	},

	{
		key = "h",
		show = "🚀 home",
		msg = "🚀 home tailscale up (teton)",
		--cmd = tsb .. "switch tufts;" .. tsb .. "up --exit-node=100.104.24.6",
		cmd = tsb .. " up --exit-node=teton --exit-node-allow-lan-access",
	},

	{
		key = "n",
		show = "none (do not use any exit-node)",
		msg = "no exit node",
		--cmd = tsb .. "switch tufts;" .. tsb .. "up --exit-node=100.104.24.6",
		cmd = tsb .. " up --exit-node=none --exit-node-allow-lan-access",
	},

	{
		key = "s",
		show = "🔎",
		msg = "TS status",
		cmd = "",
		fn = function()
			delay = 0.75
			local output, status = hs.execute(tsb .. " status | grep '; exit node;' | awk '{print $2}'")
			if not status then
				output = "Error running tailscale status"
			end
			if output == "" then
				output = "none"
			end

			hs.alert.show(output, hs.screen.mainScreen(), { textSize = 50 }, delay)
		end,
	},

	{
		key = "t",
		show = "🚀🐘",
		msg = "🚀 🐘 tailscale up (tufts)",
		--cmd = tsb .. "switch tufts;" .. tsb .. "up --exit-node=100.104.24.6",
		cmd = tsb .. " up --exit-node=hadoop-prod-04 --exit-node-allow-lan-access",
	},
}

local function SetKeys(clist)
	for _, v in ipairs(clist) do
		if v.cmd ~= "" then
			cmds_cmodal:bind("", v.key, v.msg, function()
				spoon.ModalMgr:deactivate({ modalTS })
				if v.show ~= "" then
					hs.alert.show(v.show, hs.screen.mainScreen(), { textSize = 80 }, 0.75)
				end
				hs.execute(v.cmd)
			end)
		elseif v.fn then
			cmds_cmodal:bind("", v.key, v.msg, function()
				spoon.ModalMgr:deactivate({ modalTS })
				if v.show ~= "" then
					hs.alert.show(v.show, hs.screen.mainScreen(), { textSize = 80 }, 0.75)
				end
				v.fn()
			end)
		end
	end
end

-- TODO: use this function for all the other places where we set keys
SetKeys(cmds_list)

----------------
-- CMDS modal (M) --
----------------
spoon.ModalMgr.supervisor:bind(hyper, "m", "Enter cmd Environment", function()
	spoon.ModalMgr:deactivateAll()
	spoon.ModalMgr:activate({ "cmds" }, "#2244FF", false)
end)

spoon.ModalMgr:new("cmds")
local cmds_cmodal = spoon.ModalMgr.modal_list["cmds"]
cmds_cmodal:bind("", "escape", "Deactivate CMDS", function()
	spoon.ModalMgr:deactivate({ "cmds" })
end)
cmds_cmodal:bind("", "Q", "Deactivate CMDS", function()
	spoon.ModalMgr:deactivate({ "cmds" })
end)
cmds_cmodal:bind("", "tab", "Toggle Cheatsheet", function()
	spoon.ModalMgr:toggleCheatsheet()
end)

local cmds_list = {
	-- cmd for shell comands, fn for hs code
	{
		key = "b",
		show = "",
		msg = "🔋 battery status",
		cmd = "",
		fn = function()
			hs.alert.show(battery(), hs.screen.mainScreen(), { textSize = 40 }, 2)
		end,
	},
	{
		key = "d",
		show = "🐘 ⬇️",
		msg = "🐘 ⬇️  tailscale down",
		--cmd = tsb .. " up --exit-node=;",
		cmd = tsb .. " down",
	},
	{
		key = "e",
		show = "🧪",
		msg = "test",
		cmd = "",
		fn = function()
			hs.alert.show("Hello World!")
		end,
	},
	{
		key = "k",
		show = "",
		msg = "🎹 toggle keyboard",
		cmd = "",
		fn = function()
			drdKeyboard.toggleInput()
		end,
	},
	{
		key = "i",
		show = "🚪",
		msg = "🚪 minimize all windows",
		cmd = "",
		fn = function()
			drdWindows.minimizeAll()
		end,
	},
	{
		key = "l",
		show = "🔒",
		msg = "🔒 lockscreen",
		cmd = "",
		fn = function()
			hs.caffeinate.lockScreen()
		end,
	},
	{
		key = "m",
		show = "",
		msg = "⏰ show date and time",
		cmd = "",
		fn = function()
			local time = os.date("%A, %d %B %Y, %H:%M")
			hs.alert.show(time)
			hs.pasteboard.setContents(time)
		end,
	},
	{
		key = "o",
		show = "📚",
		msg = "📚 books",
		cmd = 'open "/Users/drio/Library/Mobile Documents/com~apple~CloudDocs/drio-dropbox/books"',
		fn = function()
			hs.caffeinate.lockScreen()
		end,
	},
	{
		key = "p",
		show = "✨",
		msg = "✨ copy tufts pass",
		cmd = "/Users/drio/dev/github.com/drio/dotfiles/.config/zsh/scripts/tp",
	},
	{
		key = "r",
		show = "🚙",
		msg = "🚙 reload config",
		cmd = "",
		fn = function()
			hs.reload()
		end,
	},

	{
		key = "s",
		show = "🔑",
		msg = "🔑 ssh up",
		cmd = "/Users/drio/dev/github.com/drio/dotfiles/.config/zsh/scripts/ssher up",
	},
	{
		key = "n",
		show = "🔑⬇️",
		msg = "🔑⬇️  ssh down",
		cmd = "/Users/drio/dev/github.com/drio/dotfiles/.config/zsh/scripts/ssher down",
	},

	{
		key = "u",
		show = "☀️",
		msg = "☀️ 100% brightness",
		-- fn = function()
		-- 	hs.brightness.set(100)
		-- end,
		--
		cmd = "/Users/drio/dev/github.com/drio/dotfiles/.config/zsh/scripts/bright up",
	},
	{
		key = "v",
		show = "👾",
		msg = "👾 vnc rufus",
		cmd = "/Users/drio/dev/github.com/drio/dotfiles/.config/zsh/scripts/vrufus",
	},
	--{key = 't', show='🐘 🚀', msg='🐘 🚀 tailscale up', cmd = '/Applications/Tailscale.app/Contents/MacOS/Tailscale up --exit-node=100.77.59.88' },
	{
		key = "t",
		show = "🐘 🚀 🫧",
		msg = "🐘 🚀 🫧 tailscale up (bubbles)",
		--cmd = tsb .. "switch tufts;" .. tsb .. "up --exit-node=100.104.24.6",
		cmd = tsb .. " up --exit-node=100.89.191.30",
	},
	{
		key = "y",
		show = "synergy up",
		msg = "synergy up",
		cmd = "/Users/drio/dev/github.com/drio/dotfiles/.config/zsh/scripts/start-synergy up",
	},
}
for _, v in ipairs(cmds_list) do
	if v.cmd ~= "" then
		cmds_cmodal:bind("", v.key, v.msg, function()
			spoon.ModalMgr:deactivate({ "cmds" })
			if v.show ~= "" then
				hs.alert.show(v.show, hs.screen.mainScreen(), { textSize = 80 }, 0.75)
			end
			hs.execute(v.cmd)
		end)
	elseif v.fn then
		cmds_cmodal:bind("", v.key, v.msg, function()
			spoon.ModalMgr:deactivate({ "cmds" })
			if v.show ~= "" then
				hs.alert.show(v.show, hs.screen.mainScreen(), { textSize = 80 }, 0.75)
			end
			v.fn()
		end)
	end
end
--------------------
-- CMDS MODAL END --
--------------------

--[[
hs.hotkey.bind(hyper, "-", "Invert screen", function()
  invertScreen()
end)
hs.hotkey.bind(hyper, "=", "Normal screen", function()
  normalScreen()
end)
--]]

-- App launcher
spoon.ModalMgr.supervisor:bind(hyper, "space", "Enter AppM Environment", function()
	spoon.ModalMgr:deactivateAll()
	spoon.ModalMgr:activate({ "appM" }, "#FFBD2E", false)
end)

spoon.ModalMgr:new("appM")
local app_cmodal = spoon.ModalMgr.modal_list["appM"]
app_cmodal:bind("", "escape", "Deactivate appM", function()
	spoon.ModalMgr:deactivate({ "appM" })
end)
app_cmodal:bind("", "Q", "Deactivate appM", function()
	spoon.ModalMgr:deactivate({ "appM" })
end)
app_cmodal:bind("", "tab", "Toggle Cheatsheet", function()
	spoon.ModalMgr:toggleCheatsheet()
end)

-- Use: osascript -e 'id of app "SQLDeveloper"' to get app ID
local hsapp_list = {
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
for _, v in ipairs(hsapp_list) do
	if v.id then
		local located_name = hs.application.nameForBundleID(v.id)
		if located_name then
			app_cmodal:bind("", v.key, located_name, function()
				hs.application.launchOrFocusByBundleID(v.id)
				spoon.ModalMgr:deactivate({ "appM" })
			end)
		end
	elseif v.name then
		app_cmodal:bind("", v.key, v.name, function()
			hs.application.launchOrFocus(v.name)
			spoon.ModalMgr:deactivate({ "appM" })
		end)
	end
end
-- END app launcher

if spoon.WinWin then
	spoon.ModalMgr:new("resizeM")
	local _cmodal = spoon.ModalMgr.modal_list["resizeM"]
	_cmodal:bind("", "escape", "Deactivate resizeM", function()
		spoon.ModalMgr:deactivate({ "resizeM" })
	end)
	_cmodal:bind("", "Q", "Deactivate resizeM", function()
		spoon.ModalMgr:deactivate({ "resizeM" })
	end)
	_cmodal:bind("", "tab", "Toggle Cheatsheet", function()
		spoon.ModalMgr:toggleCheatsheet()
	end)

	_cmodal:bind(
		"",
		"A",
		"Move Leftward",
		function()
			spoon.WinWin:stepMove("left")
		end,
		nil,
		function()
			spoon.WinWin:stepMove("left")
		end
	)
	_cmodal:bind(
		"",
		"D",
		"Move Rightward",
		function()
			spoon.WinWin:stepMove("right")
		end,
		nil,
		function()
			spoon.WinWin:stepMove("right")
		end
	)
	_cmodal:bind(
		"",
		"W",
		"Move Upward",
		function()
			spoon.WinWin:stepMove("up")
		end,
		nil,
		function()
			spoon.WinWin:stepMove("up")
		end
	)
	_cmodal:bind(
		"",
		"S",
		"Move Downward",
		function()
			spoon.WinWin:stepMove("down")
		end,
		nil,
		function()
			spoon.WinWin:stepMove("down")
		end
	)

	_cmodal:bind("", "H", "Lefthalf of Screen", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("halfleft")
	end)
	_cmodal:bind("", "L", "Righthalf of Screen", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("halfright")
	end)
	_cmodal:bind("", "K", "Uphalf of Screen", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("halfup")
	end)
	_cmodal:bind("", "J", "Downhalf of Screen", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("halfdown")
	end)

	_cmodal:bind("", "Y", "NorthWest Corner", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("cornerNW")
	end)
	_cmodal:bind("", "O", "NorthEast Corner", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("cornerNE")
	end)
	_cmodal:bind("", "U", "SouthWest Corner", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("cornerSW")
	end)
	_cmodal:bind("", "I", "SouthEast Corner", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("cornerSE")
	end)

	_cmodal:bind("", "F", "Fullscreen", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("fullscreen")
	end)
	_cmodal:bind("", "C", "Center Window", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("center")
	end)

	_cmodal:bind(
		"",
		"=",
		"Stretch Outward",
		function()
			spoon.WinWin:moveAndResize("expand")
		end,
		nil,
		function()
			spoon.WinWin:moveAndResize("expand")
		end
	)
	_cmodal:bind(
		"",
		"-",
		"Shrink Inward",
		function()
			spoon.WinWin:moveAndResize("shrink")
		end,
		nil,
		function()
			spoon.WinWin:moveAndResize("shrink")
		end
	)

	_cmodal:bind(
		"shift",
		"H",
		"Move Leftward",
		function()
			spoon.WinWin:stepResize("left")
		end,
		nil,
		function()
			spoon.WinWin:stepResize("left")
		end
	)
	_cmodal:bind(
		"shift",
		"L",
		"Move Rightward",
		function()
			spoon.WinWin:stepResize("right")
		end,
		nil,
		function()
			spoon.WinWin:stepResize("right")
		end
	)
	_cmodal:bind(
		"shift",
		"K",
		"Move Upward",
		function()
			spoon.WinWin:stepResize("up")
		end,
		nil,
		function()
			spoon.WinWin:stepResize("up")
		end
	)
	_cmodal:bind(
		"shift",
		"J",
		"Move Downward",
		function()
			spoon.WinWin:stepResize("down")
		end,
		nil,
		function()
			spoon.WinWin:stepResize("down")
		end
	)

	_cmodal:bind("", "left", "Move to Left Monitor", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveToScreen("left")
	end)
	_cmodal:bind("", "right", "Move to Right Monitor", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveToScreen("right")
	end)
	_cmodal:bind("", "up", "Move to Above Monitor", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveToScreen("up")
	end)
	_cmodal:bind("", "down", "Move to Below Monitor", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveToScreen("down")
	end)
	_cmodal:bind("", "space", "Move to Next Monitor", function()
		spoon.WinWin:stash()
		spoon.WinWin:moveToScreen("next")
	end)

	_cmodal:bind("", "[", "Undo Window Manipulation", function()
		spoon.WinWin:undo()
	end)
	_cmodal:bind("", "]", "Redo Window Manipulation", function()
		spoon.WinWin:redo()
	end)
	_cmodal:bind("", "`", "Center Cursor", function()
		spoon.WinWin:centerCursor()
	end)

	spoon.ModalMgr.supervisor:bind(hyper, "O", "Enter resizeM Environment", function()
		-- Deactivate some modal environments or not before activating a new one
		spoon.ModalMgr:deactivateAll()
		-- Show an status indicator so we know we're in some modal environment now
		spoon.ModalMgr:activate({ "resizeM" }, "#FF0000", false)
	end)
end

if spoon.CountDown then
	spoon.ModalMgr:new("countdownM")
	local count_modal = spoon.ModalMgr.modal_list["countdownM"]
	count_modal:bind("", "escape", "Deactivate countdownM", function()
		spoon.ModalMgr:deactivate({ "countdownM" })
	end)
	count_modal:bind("", "Q", "Deactivate countdownM", function()
		spoon.ModalMgr:deactivate({ "countdownM" })
	end)
	count_modal:bind("", "tab", "Toggle Cheatsheet", function()
		spoon.ModalMgr:toggleCheatsheet()
	end)
	count_modal:bind("", "0", "5 Minutes Countdown", function()
		spoon.CountDown:startFor(5)
		spoon.ModalMgr:deactivate({ "countdownM" })
	end)
	for i = 1, 9 do
		count_modal:bind("", tostring(i), string.format("%s Minutes Countdown", 10 * i), function()
			spoon.CountDown:startFor(10 * i)
			spoon.ModalMgr:deactivate({ "countdownM" })
		end)
	end
	count_modal:bind("", "return", "25 Minutes Countdown", function()
		spoon.CountDown:startFor(25)
		spoon.ModalMgr:deactivate({ "countdownM" })
	end)
	count_modal:bind("", "space", "Pause/Resume CountDown", function()
		spoon.CountDown:pauseOrResume()
		spoon.ModalMgr:deactivate({ "countdownM" })
	end)

	-- Register countdownM with modal supervisor
	hscountdM_keys = { "cmd", "6" }
	if string.len(hscountdM_keys[2]) > 0 then
		spoon.ModalMgr.supervisor:bind(hscountdM_keys[1], hscountdM_keys[2], "Enter countdownM Environment", function()
			spoon.ModalMgr:deactivateAll()
			-- Show the keybindings cheatsheet once countdownM is activated
			spoon.ModalMgr:activate({ "countdownM" }, "#22A311", false)
		end)
	end
end

spoon.ModalMgr.supervisor:enter()

-- https://github.com/zzamboni/dot-hammerspoon/blob/master/init.lua#L319
Install:andUse("Seal", {
	hotkeys = { show = { { "cmd" }, "E" } },
	fn = function(s)
		s:loadPlugins({ "apps", "calc", "safari_bookmarks", "screencapture", "useractions" })
		s.plugins.safari_bookmarks.always_open_with_safari = false
		s.plugins.useractions.actions = {
			["Hammerspoon docs webpage"] = {
				url = "http://hammerspoon.org/docs/",
				icon = hs.image.imageFromName(hs.image.systemImageNames.ApplicationIcon),
			},
		}
		s:refreshAllCommands()
	end,
	start = true,
})

Install:andUse("FadeLogo", {
	config = { default_run = 1.0 },
	start = true,
})

Install:andUse("TextClipboardHistory", {
	disable = false,
	config = {
		show_in_menubar = false,
	},
	hotkeys = {
		toggle_clipboard = { { "cmd", "shift" }, "v" },
	},
	start = true,
})
