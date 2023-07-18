local M = {}

M.Load = function(hyper)
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

	_cmodal:bind("", "space", "move to next screen", function()
		local s = hs.window.focusedWindow():screen()
		hs.window.focusedWindow():moveToScreen(s:previous())
	end)

	_cmodal:bind("", "=", "expand", function()
		spoon.WinWin:moveAndResize("expand")
	end)

	_cmodal:bind("", "-", "shrink", function()
		spoon.WinWin:moveAndResize("shrink")
	end)

	_cmodal:bind("", "c", "center", function()
		hs.window.focusedWindow():centerOnScreen()
		spoon.ModalMgr:deactivateAll()
	end)

	_cmodal:bind("", "f", "Fullscreen", function()
		hs.window.focusedWindow():maximize()
		--spoon.ModalMgr:deactivateAll()
	end)

	_cmodal:bind("", "h", "left50", function()
		hs.window.focusedWindow():moveToUnit(hs.layout.left50)
	end)
	_cmodal:bind("", "l", "right50", function()
		hs.window.focusedWindow():moveToUnit(hs.layout.right50)
	end)

	_cmodal:bind("", "[", "left30", function()
		hs.window.focusedWindow():moveToUnit(hs.layout.left30)
	end)
	_cmodal:bind("", "]", "right30", function()
		hs.window.focusedWindow():moveToUnit(hs.layout.right30)
	end)

	spoon.ModalMgr.supervisor:bind(hyper, "O", "Enter resizeM Environment", function()
		spoon.ModalMgr:deactivateAll()
		spoon.ModalMgr:activate({ "resizeM" }, "#FF0000", false)
	end)
end

return M
