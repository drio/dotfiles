local module = {}

local es = "Spanish"
local us = "U.S."
local flags = {
  us = "🇺🇸",
  es = "🇪🇸"
}

module.toggleInput = function()
  local curr = hs.keycodes.currentLayout()
  print("-- curr: " ..  curr)
  local show = function(msg) 
    hs.alert.show(msg, hs.screen.mainScreen(), {textSize = 80}, 1)
  end

  print("-" .. curr .. "-")
  if curr == us then
    print("setting to: ", es)
    hs.keycodes.setLayout(es)
    show(flags.es)
  else
    print("setting to: ", us)
    hs.keycodes.setLayout(us)
    show(flags.us)
  end
end

return module
