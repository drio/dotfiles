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
hs.loadSpoon("CountDown")

spoon.SpoonInstall.use_syncinstall = true
local Install = spoon.SpoonInstall

local hyper = {"cmd","alt","ctrl"}


hs.hotkey.bind(hyper, "-", "Invert screen", function()
  print("asdfasdf")
  invertScreen()
end)
hs.hotkey.bind(hyper, "=", "Normal screen", function()
  normalScreen()
end)



hs.hotkey.bind(hyper, "R", "Reload Configuration", function()
  hs.reload()
end)

-- App launcher
spoon.ModalMgr.supervisor:bind(hyper, "space", "Enter AppM Environment", function()
    spoon.ModalMgr:deactivateAll()
    spoon.ModalMgr:activate({"appM"}, "#FFBD2E", false)
end)

spoon.ModalMgr:new("appM")
local app_cmodal = spoon.ModalMgr.modal_list["appM"]
app_cmodal:bind('', 'escape', 'Deactivate appM', function() spoon.ModalMgr:deactivate({"appM"}) end)
app_cmodal:bind('', 'Q', 'Deactivate appM', function() spoon.ModalMgr:deactivate({"appM"}) end)
app_cmodal:bind('', 'tab', 'Toggle Cheatsheet', function() spoon.ModalMgr:toggleCheatsheet() end)

-- Use: osascript -e 'id of app "SQLDeveloper"' to get app ID
local hsapp_list = {
    --{key = '1', name = '1Password 7'},
    --{key = 'a', name = 'Obsidian'},
    {key = 'b', name = 'Brave Browser'},
    {key = 'c', name = 'Calendar'},
    {key = 'd', name = 'Bitwarden'},
    {key = 'e', name = 'Firefox'},
    {key = 'f', name = 'Finder'},
    {key = 'g', name = 'Telegram'},
    --{key = 'h', name = 'Telegram'},
    {key = 'i', name = 'iTerm'},
    --{key = 'j', name = 'Slack'},
    --{key = 'k', name = 'Slack'},
    --{key = 'l', name = 'Spotlight'},
    {key = 'm', name = 'Mail'},
    {key = 'n', name = 'Notes'},
    {key = 'o', name = 'Reolink Client'},
    {key = 'p', name = 'mpv'},
    --{key = 'q', name = 'mpv'},
    {key = 'r', name = 'Preview'},
    {key = 's', name = 'Safari'},
    {key = 't', name = 'NetNewsWire'},
    --{key = 'u', name = 'Music'},
    {key = 'v', id = 'com.apple.ActivityMonitor'},
    {key = 'w', name = 'WhatsApp'},
    --{key = 'x', name = 'WhatsApp'},
    {key = 'y', id = 'com.apple.systempreferences'},
    --{key = 'z', id = 'com.apple.systempreferences'},
}
for _, v in ipairs(hsapp_list) do
    if v.id then
        local located_name = hs.application.nameForBundleID(v.id)
        if located_name then
            app_cmodal:bind('', v.key, located_name, function()
                hs.application.launchOrFocusByBundleID(v.id)
                spoon.ModalMgr:deactivate({"appM"})
            end)
        end
    elseif v.name then app_cmodal:bind('', v.key, v.name, function()
            hs.application.launchOrFocus(v.name)
            spoon.ModalMgr:deactivate({"appM"})
        end)
    end
end
-- END app launcher


spoon.ModalMgr.supervisor:bind(hyper, "7", "Lock Screen", function()
   hs.caffeinate.lockScreen()
end)

if spoon.WinWin then
    spoon.ModalMgr:new("resizeM")
    local _cmodal = spoon.ModalMgr.modal_list["resizeM"]
    _cmodal:bind('', 'escape', 'Deactivate resizeM', function() spoon.ModalMgr:deactivate({"resizeM"}) end)
    _cmodal:bind('', 'Q', 'Deactivate resizeM', function() spoon.ModalMgr:deactivate({"resizeM"}) end)
    _cmodal:bind('', 'tab', 'Toggle Cheatsheet', function() spoon.ModalMgr:toggleCheatsheet() end)

    _cmodal:bind('', 'A', 'Move Leftward', function() spoon.WinWin:stepMove("left") end, nil, function() spoon.WinWin:stepMove("left") end)
    _cmodal:bind('', 'D', 'Move Rightward', function() spoon.WinWin:stepMove("right") end, nil, function() spoon.WinWin:stepMove("right") end)
    _cmodal:bind('', 'W', 'Move Upward', function() spoon.WinWin:stepMove("up") end, nil, function() spoon.WinWin:stepMove("up") end)
    _cmodal:bind('', 'S', 'Move Downward', function() spoon.WinWin:stepMove("down") end, nil, function() spoon.WinWin:stepMove("down") end)

    _cmodal:bind('', 'H', 'Lefthalf of Screen', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("halfleft") end)
    _cmodal:bind('', 'L', 'Righthalf of Screen', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("halfright") end)
    _cmodal:bind('', 'K', 'Uphalf of Screen', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("halfup") end)
    _cmodal:bind('', 'J', 'Downhalf of Screen', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("halfdown") end)

    _cmodal:bind('', 'Y', 'NorthWest Corner', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("cornerNW") end)
    _cmodal:bind('', 'O', 'NorthEast Corner', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("cornerNE") end)
    _cmodal:bind('', 'U', 'SouthWest Corner', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("cornerSW") end)
    _cmodal:bind('', 'I', 'SouthEast Corner', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("cornerSE") end)

    _cmodal:bind('', 'F', 'Fullscreen', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("fullscreen") end)
    _cmodal:bind('', 'C', 'Center Window', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("center") end)

    _cmodal:bind('', '=', 'Stretch Outward', function() spoon.WinWin:moveAndResize("expand") end, nil, function() spoon.WinWin:moveAndResize("expand") end)
    _cmodal:bind('', '-', 'Shrink Inward', function() spoon.WinWin:moveAndResize("shrink") end, nil, function() spoon.WinWin:moveAndResize("shrink") end)

    _cmodal:bind('shift', 'H', 'Move Leftward', function() spoon.WinWin:stepResize("left") end, nil, function() spoon.WinWin:stepResize("left") end)
    _cmodal:bind('shift', 'L', 'Move Rightward', function() spoon.WinWin:stepResize("right") end, nil, function() spoon.WinWin:stepResize("right") end)
    _cmodal:bind('shift', 'K', 'Move Upward', function() spoon.WinWin:stepResize("up") end, nil, function() spoon.WinWin:stepResize("up") end)
    _cmodal:bind('shift', 'J', 'Move Downward', function() spoon.WinWin:stepResize("down") end, nil, function() spoon.WinWin:stepResize("down") end)

    _cmodal:bind('', 'left', 'Move to Left Monitor', function() spoon.WinWin:stash() spoon.WinWin:moveToScreen("left") end)
    _cmodal:bind('', 'right', 'Move to Right Monitor', function() spoon.WinWin:stash() spoon.WinWin:moveToScreen("right") end)
    _cmodal:bind('', 'up', 'Move to Above Monitor', function() spoon.WinWin:stash() spoon.WinWin:moveToScreen("up") end)
    _cmodal:bind('', 'down', 'Move to Below Monitor', function() spoon.WinWin:stash() spoon.WinWin:moveToScreen("down") end)
    _cmodal:bind('', 'space', 'Move to Next Monitor', function() spoon.WinWin:stash() spoon.WinWin:moveToScreen("next") end)

    _cmodal:bind('', '[', 'Undo Window Manipulation', function() spoon.WinWin:undo() end)
    _cmodal:bind('', ']', 'Redo Window Manipulation', function() spoon.WinWin:redo() end)
    _cmodal:bind('', '`', 'Center Cursor', function() spoon.WinWin:centerCursor() end)

    spoon.ModalMgr.supervisor:bind(hyper, "O", "Enter resizeM Environment", function()
        -- Deactivate some modal environments or not before activating a new one
        spoon.ModalMgr:deactivateAll()
        -- Show an status indicator so we know we're in some modal environment now
        spoon.ModalMgr:activate({"resizeM"}, "#FF0000", false)
    end)
end

if spoon.CountDown then
    spoon.ModalMgr:new("countdownM")
    local count_modal = spoon.ModalMgr.modal_list["countdownM"]
    count_modal:bind('', 'escape', 'Deactivate countdownM', function() spoon.ModalMgr:deactivate({"countdownM"}) end)
    count_modal:bind('', 'Q', 'Deactivate countdownM', function() spoon.ModalMgr:deactivate({"countdownM"}) end)
    count_modal:bind('', 'tab', 'Toggle Cheatsheet', function() spoon.ModalMgr:toggleCheatsheet() end)
    count_modal:bind('', '0', '5 Minutes Countdown', function()
        spoon.CountDown:startFor(5)
        spoon.ModalMgr:deactivate({"countdownM"})
    end)
    for i = 1, 9 do
        count_modal:bind('', tostring(i), string.format("%s Minutes Countdown", 10 * i), function()
            spoon.CountDown:startFor(10 * i)
            spoon.ModalMgr:deactivate({"countdownM"})
        end)
    end
    count_modal:bind('', 'return', '25 Minutes Countdown', function()
        spoon.CountDown:startFor(25)
        spoon.ModalMgr:deactivate({"countdownM"})
    end)
    count_modal:bind('', 'space', 'Pause/Resume CountDown', function()
        spoon.CountDown:pauseOrResume()
        spoon.ModalMgr:deactivate({"countdownM"})
    end)

    -- Register countdownM with modal supervisor
    hscountdM_keys = {"cmd", "6"}
    if string.len(hscountdM_keys[2]) > 0 then
        spoon.ModalMgr.supervisor:bind(hscountdM_keys[1], hscountdM_keys[2], "Enter countdownM Environment", function()
            spoon.ModalMgr:deactivateAll()
            -- Show the keybindings cheatsheet once countdownM is activated
            spoon.ModalMgr:activate({"countdownM"}, "#22A311", false)
        end)
    end
end

--spoon.ModalMgr.supervisor:bind(hyper, "Z", "Toggle Hammerspoon Console", function() hs.toggleConsole() end)

--require "amphetamine"

--local umount = require "umount"
--hs.hotkey.bind({"cmd", "shift"}, "U", umount)

battery = require "battery"
hs.hotkey.bind(hyper, "B", function()
    hs.alert.show(battery(), hs.screen.mainScreen(), {textSize = 40}, 2)
end)

local drdWindows = require "windows"
hs.hotkey.bind(hyper, "I", drdWindows.minimizeAll)
-- hs.hotkey.bind(hyper, "F", drdWindows.minimizeAllButFocussedWindow)


local drdKeyboard = require "keyboard"
hs.hotkey.bind(hyper, "K", drdKeyboard.toggleInput)

-- Date Handy Dandyness
hs.hotkey.bind(hyper, "\\", function()
   local time = os.date("%A, %d %B %Y, %H:%M")
   hs.alert.show(time)
   hs.pasteboard.setContents(time)
end)

spoon.ModalMgr.supervisor:enter()


--[[
local hammerHacking = (function()
  local screen = 'Color LCD'
  local topLeft = {x=0, y=0, w=.5, h=1}
  local topRight = {x=.5, y=0, w=.5, h=1}
  local windowLayout = {
    {'iTerm2', nil, screen, topLeft, nil, nil},
    {'Hammerspoon', nil, screen, topRight, nil, nil},
    --{'KeyCastr', nil, screen, bottom, nil, nil},
  }
  -- hs.application.launchOrFocus('KeyCastr')
  local hsApp = hs.appfinder.appFromName('Hammerspoon')
  local iterm = hs.appfinder.appFromName('iTerm2')
  hs.application.launchOrFocus('iTerm2')
  hsApp:unhide()
  hs.layout.apply(windowLayout)
  if iterm ~= nil then
    iterm:unhide()
    log.i("--- Perucho el rey del ajo: " .. iterm == nil)
    if iterm.mainWindow ~= nil then
      iterm:mainWindow():focus()
    end
  end
end)
--]]


Install:andUse("Caffeine", {
     start = false,
     hotkeys = {
       toggle = { hyper, "0" }
     },
--   fn = BTT_caffeine_widget,
})

Install:andUse("MouseCircle",
   {
     disable = true,
     config = { color = hs.drawing.color.x11.rebeccapurple },
     hotkeys = {
       show = { hyper, "-" }
     }
   }
)


-- https://github.com/zzamboni/dot-hammerspoon/blob/master/init.lua#L319
Install:andUse("Seal",
   {
     hotkeys = { show = { {"cmd"}, "E" } },
     fn = function(s)
       s:loadPlugins({"apps", "calc", "safari_bookmarks", "screencapture", "useractions"})
       s.plugins.safari_bookmarks.always_open_with_safari = false
       s.plugins.useractions.actions = {
          ["Hammerspoon docs webpage"] = {
            url = "http://hammerspoon.org/docs/",
            icon = hs.image.imageFromName(hs.image.systemImageNames.ApplicationIcon),
          }
       }
       s:refreshAllCommands()
     end,
     start = true,
   }
)

Install:andUse("ColorPicker",
		{
		 disable = true,
		 hotkeys = {
			 show = { hyper, "4" }
		 },
		 config = {
			 show_in_menubar = false,
		 },
		 start = true,
		}
)

--hs.alert.show("🥄", hs.screen.mainScreen(), {textSize = 80}, 1)
Install:andUse("FadeLogo", {
 config = { default_run = 1.0, },
 start = true
})
