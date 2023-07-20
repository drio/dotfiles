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

hs.hotkey.alertDuration = 0
hs.hints.showTitleThresh = 0
hs.window.animationDuration = 0

hs.loadSpoon("SpoonInstall")
hs.loadSpoon("ModalMgr")
hs.loadSpoon("WinWin")

spoon.SpoonInstall.use_syncinstall = true
local Install = spoon.SpoonInstall

local hyper = { "cmd", "alt", "ctrl" }
local modalM = require("modal-manager")
local modalApps = require("modal-space-apps")
local winMan = require("win-management")
modalM.Load(hyper)
modalApps.Load(hyper)
winMan.Load(hyper)

spoon.ModalMgr.supervisor:enter()

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

Install:andUse("RoundedCorners", { start = true })
