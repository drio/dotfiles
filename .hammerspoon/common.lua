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

local dump = function(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

module.show = show
module.exists = exists
module.tsb = "/Applications/Tailscale.app/Contents/MacOS/Tailscale"
module.dump = dump
module.screens = {
	retina = "Built-in Retina Display",
	LG = "LG",
}

return module
