local module = {}

module.minimizeAll = function()
	local wins = hs.window.allWindows()
	for i = 1, #wins do
    local app = wins[i]:application()
    if app then
      app:hide()
    end
  end
end

module.minimizeAlls = function()
   for _,w in pairs(hs.window.allWindows()) do
     w:minimize()
   end
end

module.minimizeAllButFocussedWindow = function()
   local focusWindow = hs.window.focusedWindow()

   for _,w in pairs(hs.window.allWindows()) do
      if w ~= focusWindow then
         w:minimize()
      end
   end
end


return module
