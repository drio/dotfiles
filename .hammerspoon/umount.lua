drd = require('common')

local disks = {
  ssd = '/Volumes/SSD-1Tb', 
  wd = '/Volumes/WD Elements 2Gb'
}

local function umountDrives()
  local any_failure = false
  local show = drd.show
  for name, dir in pairs(disks) do
		if drd.exists(dir) then
			show("trying to umount: " .. name, 1)
  		ok = hs.fs.volume.eject(dir)
			if ok then
				show("🟢", 1)
			else
				show("🔴", 1)
        any_failure = true
			end
		end
  end
  if any_failure then
		show("👎", 2)
  else
		show("👍", 2)
  end
end

return umountDrives
