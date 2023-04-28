local module = {}

local battery = require("battery")
local drdWindows = require("windows")
local drdKeyboard = require("keyboard")
local common = require("common")
local tsb = common.tsb

local keys = {
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

	{
		key = "1",
		show = "load cams feeds",
		msg = "load cam feeds",
		cmd = "",
		fn = function()
			local output, status = os.execute("/Users/drio/dev/iot/reolink/general/viewall.sh")
			local delay = 0.5
			hs.alert.show("--> " + output + status, hs.screen.mainScreen(), { textSize = 50 }, delay)
		end,
	},

	{
		key = "2",
		show = "load cams feeds (screen 2)",
		msg = "load cam feeds (screen 2)",
		cmd = "",
		fn = function()
			local output, status = os.execute("/Users/drio/dev/iot/reolink/general/viewall.sh 1200 890 2")
			local delay = 0.5
			hs.alert.show("--> " + output + status, hs.screen.mainScreen(), { textSize = 50 }, delay)
		end,
	},

	{
		key = "6",
		show = "cams",
		msg = "bring cams to front",
		cmd = "",
		fn = function()
			local wins = hs.window.allWindows()
			drdWindows.minimizeAll()
			for _, w in pairs(wins) do
				local name = w:application():name()
				if name == "mpv" then
					w:focus()
				end
			end
		end,
	},

	{
		key = "7",
		show = "hide all cams",
		msg = "hide all cams",
		cmd = "",
		fn = function()
			local wins = hs.window.allWindows()
			for _, w in pairs(wins) do
				local app = w:application()
				local name = app:name()
				if name == "mpv" then
					hs.eventtap.keyStroke({ "cmd" }, "h", 200, app)
				end
			end
		end,
	},

	{
		key = "0",
		show = "close cams",
		msg = "close all cams",
		cmd = "",
		fn = function()
			local wins = hs.window.allWindows()
			drdWindows.minimizeAll()
			for _, w in pairs(wins) do
				local app = w:application()
				local name = app:name()
				if name == "mpv" then
					hs.eventtap.keyStroke({}, "q", 200, app)
				end
			end
		end,
	},
}

module.Load = function(hyper)
	spoon.ModalMgr.supervisor:bind(hyper, "m", "Enter cmd Environment", function()
		spoon.ModalMgr:deactivateAll()
		spoon.ModalMgr:activate({ "cmds" }, "#2244FF", false)
	end)

	spoon.ModalMgr:new("cmds")
	local modal = spoon.ModalMgr.modal_list["cmds"]
	modal:bind("", "escape", "Deactivate CMDS", function()
		spoon.ModalMgr:deactivate({ "cmds" })
	end)
	modal:bind("", "Q", "Deactivate CMDS", function()
		spoon.ModalMgr:deactivate({ "cmds" })
	end)
	modal:bind("", "tab", "Toggle Cheatsheet", function()
		spoon.ModalMgr:toggleCheatsheet()
	end)

	common.setKeys(keys, modal)
end

return module
