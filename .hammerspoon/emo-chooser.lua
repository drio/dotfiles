-- https://github.com/aldur/dotfiles/tree/master/osx/hammerspoon
-- https://aldur.github.io/articles/hammerspoon-emojis/
--
-- Build the list of emojis to be displayed.
local choices = {}
for _, emoji in ipairs(hs.json.decode(io.open("emojis/emojis.json"):read())) do
	table.insert(choices, {
		text = emoji["name"],
		subText = table.concat(emoji["kwds"], ", "),
		image = hs.image.imageFromPath("emojis/" .. emoji["id"] .. ".png"),
		chars = emoji["chars"],
	})
end

-- Create the chooser.
-- On selection, copy the emoji and type it into the focused application.
local chooser = hs.chooser.new(function(choice)
	if not choice then
		common.focusLastFocused()
		return
	end
	hs.pasteboard.setContents(choice["chars"])
	common.focusLastFocused()
	hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)

chooser:searchSubText(true)
chooser:choices(choices)

return chooser
