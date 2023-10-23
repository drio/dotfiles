local M = {}

local battery = require("battery")
local drdWindows = require("windows")
local drdKeyboard = require("keyboard")
local common = require("common")
local tsb = common.tsb

-- chooser
local emoChooser = require("emo-chooser")
local tailChooser = require("tail-chooser")

local keysI = {
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
		key = "c",
		show = "",
		msg = "toogle console",
		cmd = "",
		fn = function()
			hs.toggleConsole()
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
local keysTailscale = {
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
		key = "g",
		show = "🚀 gabi",
		msg = "🚀 tailscale up (gabi)",
		cmd = tsb .. " up --exit-node=gabi --exit-node-allow-lan-access",
	},

	{
		key = "h",
		show = "🚀 home",
		msg = "🚀 home tailscale up (teton)",
		cmd = tsb .. " up --exit-node=teton --exit-node-allow-lan-access",
	},

	{
		key = "n",
		show = "none (do not use any exit-node)",
		msg = "no exit node",
		cmd = tsb .. " up --exit-node=none --exit-node-allow-lan-access",
	},

	{
		key = "s",
		show = "",
		msg = "TS status",
		cmd = "",
		fn = function()
			local delay = 1.3
			local output, status
			output, status = hs.execute(tsb .. " status | grep '; exit node;' | awk '{print $2}'")
			if not status then
				output = "Error running tailscale status"
			end
			if output == "" then
				output = "none"
			end

			hs.alert.show(output, hs.screen.mainScreen(), { textSize = 50 }, delay)

			output, status = hs.execute(tsb .. " switch --list  | grep '*' | awk '{print $1}'")
			if not status then
				output = "Error running tailscale switch"
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
		cmd = tsb .. " up --exit-node=hadoop-prod-04 --exit-node-allow-lan-access",
	},

	{
		key = "u",
		show = "🚀plain up",
		msg = "🚀 🐘 tailscale up",
		cmd = tsb .. " up ",
	},

	{
		key = "w",
		show = "",
		msg = "switch",
		cmd = "",
		fn = function()
			tailChooser:show()
		end,

		-- function()
		-- 	local delay = 1
		-- 	local output, status = hs.execute("/Users/drio/.config/zsh/scripts/tsswitch")
		-- 	if not status then
		-- 		output = "Error running script"
		-- 	end
		--
		-- 	hs.alert.show(output, hs.screen.mainScreen(), { textSize = 75 }, delay)
		-- end,
	},

	{
		key = "v",
		show = "",
		msg = "version",
		cmd = "",
		fn = function()
			local delay = 1
			local output, status = hs.execute("/Users/drio/.config/zsh/scripts/tScaleVCheck")
			if not status then
				output = "Error getting latest versions"
			end

			hs.alert.show(output, hs.screen.mainScreen(), { textSize = 75 }, delay)
		end,
	},
}

local keysToModal = {
	{
		key = "m",
		mid = "cams",
		color = "#2244FF",
		msg = "Fooo",
		keys = keysI,
	},
	{
		key = "i",
		mid = "tailscale",
		color = "#FF1493",
		msg = "tailscale",
		keys = keysTailscale,
	},
}

M.Load = function(hyper)
	for _, e in pairs(keysToModal) do
		spoon.ModalMgr.supervisor:bind(hyper, e.key, e.msg, function()
			spoon.ModalMgr:deactivateAll()
			spoon.ModalMgr:activate({ e.mid }, e.color, false)
		end)

		spoon.ModalMgr:new(e.mid)
		local modal = spoon.ModalMgr.modal_list[e.mid]

		modal:bind("", "escape", "Deactivate", function()
			spoon.ModalMgr:deactivate({ e.mid })
		end)

		modal:bind("", "Q", "Deactivate", function()
			spoon.ModalMgr:deactivate({ e.mid })
		end)

		modal:bind("", "tab", "Toggle Cheatsheet", function()
			spoon.ModalMgr:toggleCheatsheet()
		end)

		for _, v in ipairs(e.keys) do
			if v.cmd ~= "" then
				modal:bind("", v.key, v.msg, function()
					spoon.ModalMgr:deactivate({ e.mid })
					if v.show ~= "" then
						hs.alert.show(v.show, hs.screen.mainScreen(), { textSize = 80 }, 0.75)
					end
					hs.execute(v.cmd)
				end)
			elseif v.fn then
				modal:bind("", v.key, v.msg, function()
					spoon.ModalMgr:deactivate({ e.mid })
					if v.show ~= "" then
						hs.alert.show(v.show, hs.screen.mainScreen(), { textSize = 80 }, 0.75)
					end
					v.fn()
				end)
			end
		end
	end
end

return M
