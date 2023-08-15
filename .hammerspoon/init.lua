--[[
Useful references:
  - https://github.com/zzamboni/dot-hammerspoon
  - https://github.com/jhkuperus/dotfiles/blob/master/hammerspoon/init.lua
  - https://github.com/cmsj/hammerspoon-config/blob/master/init.lua
  - https://github.com/quickdraw6906/hammerspoon-pc
  - https://wiki.nikitavoloboev.xyz/macos/macos-apps/hammerspoon

  https://www.hammerspoon.org/Spoons/index.html
--]]

-- Required to use with the cli tool: /Applications/Hammerspoon.app/Contents/Frameworks/hs/hs
require("hs.ipc")
require("cli")

-- Ensure the IPC command line client is available
hs.ipc.cliInstall()

hs.hotkey.alertDuration = 0
hs.hints.showTitleThresh = 0
hs.window.animationDuration = 0

local hyper = { "cmd", "alt", "ctrl" }
local superhyper = { "shift", "cmd", "alt", "ctrl" }

hs.loadSpoon("SpoonInstall")
hs.loadSpoon("ModalMgr")
hs.loadSpoon("WinWin")

spoon.SpoonInstall.use_syncinstall = true
local Install = spoon.SpoonInstall

-- chooser
local emoChooser = require("emo-chooser")
hs.hotkey.bind(hyper, "J", function()
	emoChooser:show()
end)

-- This draws a bright red circle around the pointer for a few seconds
Install:andUse("MouseCircle", { hotkeys = { show = { hyper, "0" } } })

local modalM = require("modal-manager")
local modalApps = require("modal-space-apps")
local winMan = require("win-management")
modalM.Load(hyper)
modalApps.Load(hyper)
winMan.Load(hyper)

spoon.ModalMgr.supervisor:enter()

local winGeo = require("win-geometry")
winGeo.Load(hyper)

Install:andUse("Seal", {
	hotkeys = { show = { { "cmd" }, "E" } },
	fn = function(s)
		s:loadPlugins({
			"apps",
			"calc",
			"safari_bookmarks",
			"screencapture",
			"useractions",
			"filesearch",
		})
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

hs.notify
	.new({
		title = "Hammerspoon",
		informativeText = "Config loaded",
	})
	:send()
