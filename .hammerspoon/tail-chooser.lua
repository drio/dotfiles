local common = require("common")
local tsb = common.tsb

local tsImg = hs.image.imageFromPath("imgs/tailscale.png") --drio(TuftsDST) *
local tss = "/Users/drio/.config/zsh/scripts/tsswitch"
--driode01@tufts.edu
--driodeiros@gmail.com

local choices = {
	{
		text = "personal drio",
		--subText = "main",
		image = tsImg,
		cmd = tss .. " driodeiros@gmail.com",
	},
	{
		text = "tufts github",
		--subText = "main",
		image = tsImg,
		cmd = tss .. " 'drio(TuftsDST)'",
	},
	{
		text = "tufts microsoft",
		--subText = "main",
		image = tsImg,
		cmd = tss .. " driode01@tufts.edu",
	},
	{
		text = "up ⬆",
		--subText = "main",
		image = tsImg,
		cmd = tsb .. " up",
	},
	{
		text = "down ⬇",
		--subText = "main",
		image = tsImg,
		cmd = tsb .. " down",
	},
}

-- Create the chooser.
-- On selection, copy the emoji and type it into the focused application.
local chooser = hs.chooser.new(function(choice)
	if not choice then
		common.focusLastFocused()
		return
	end

	hs.alert.show("running", hs.screen.mainScreen(), { textSize = 50 }, 2)
	local output, status = hs.execute(choice["cmd"])
	local msg = "ok"
	if not status then
		msg = "error: " .. output
	end
	hs.alert.show(msg, hs.screen.mainScreen(), { textSize = 50 }, 2)
end)

chooser:searchSubText(true)
chooser:choices(choices)

return chooser
