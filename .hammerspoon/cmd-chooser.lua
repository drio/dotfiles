local common = require("common")

local sshImg = hs.image.imageFromPath("imgs/openssh.jpg")

local choices = {
	{
		text = "h4: hadoop4 (tmux)",
		--subText = "main",
		image = sshImg,
		cmd = "/Users/drio/.config/zsh/scripts/jssh h4",
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
