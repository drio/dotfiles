local module = {}

local style = { textSize = 80 }

local show = function(msg, secs)
	hs.alert.show(msg, hs.screen.mainScreen(), style, secs)
end

--- Check if a file or directory exists in this path
local function exists(file)
	local ok, err, code = os.rename(file, file)
	if not ok then
		if code == 13 then
			-- Permission denied, but it exists
			return true
		end
	end
	return ok, err
end

local function setKeys(clist, modal)
	for _, v in ipairs(clist) do
		if v.cmd ~= "" then
			modal:bind("", v.key, v.msg, function()
				spoon.ModalMgr:deactivate({ modal })
				if v.show ~= "" then
					hs.alert.show(v.show, hs.screen.mainScreen(), { textSize = 80 }, 0.75)
				end
				hs.execute(v.cmd)
			end)
		elseif v.fn then
			modal:bind("", v.key, v.msg, function()
				spoon.ModalMgr:deactivate({ modal })
				if v.show ~= "" then
					hs.alert.show(v.show, hs.screen.mainScreen(), { textSize = 80 }, 0.75)
				end
				v.fn()
			end)
		end
	end
end

module.show = show
module.exists = exists
module.tsb = "/Applications/Tailscale.app/Contents/MacOS/Tailscale"
module.setKeys = setKeys

return module
