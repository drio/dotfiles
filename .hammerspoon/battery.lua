
local function batteryInfo()
  local b = hs.battery
  return "🔋" .. b.percentage() .. "%\n" ..  b.powerSource() 
end

return batteryInfo
