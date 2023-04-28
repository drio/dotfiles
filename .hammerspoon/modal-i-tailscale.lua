local module = {}

local common = require("common")
local tsb = common.tsb

local modalTS = "cmds ts"

local keys = {
	{
		key = "b",
		show = "🚀 🫧",
		msg = "🚀 🫧 tailscale up (bubbles)",
		--cmd = tsb .. "switch tufts;" .. tsb .. "up --exit-node=100.104.24.6",
		cmd = tsb .. " up --exit-node=bubbles --exit-node-allow-lan-access",
	},

	{
		key = "d",
		show = "TS ⬇️",
		msg = "TS ⬇️  tailscale down",
		cmd = tsb .. " down",
	},

	{
		key = "g",
		show = "🚀 gabi",
		msg = "🚀 tailscale up (gabi)",
		cmd = tsb .. " up --exit-node=gabi --exit-node-allow-lan-access",
	},

	{
		key = "h",
		show = "🚀 home",
		msg = "🚀 home tailscale up (teton)",
		cmd = tsb .. " up --exit-node=teton --exit-node-allow-lan-access",
	},

	{
		key = "n",
		show = "none (do not use any exit-node)",
		msg = "no exit node",
		cmd = tsb .. " up --exit-node=none --exit-node-allow-lan-access",
	},

	{
		key = "s",
		show = "",
		msg = "TS status",
		cmd = "",
		fn = function()
			local delay = 1.3
			local output, status
			output, status = hs.execute(tsb .. " status | grep '; exit node;' | awk '{print $2}'")
			if not status then
				output = "Error running tailscale status"
			end
			if output == "" then
				output = "none"
			end

			hs.alert.show(output, hs.screen.mainScreen(), { textSize = 50 }, delay)

			output, status = hs.execute(tsb .. " switch --list  | grep '*' | awk '{print $1}'")
			if not status then
				output = "Error running tailscale switch"
			end
			if output == "" then
				output = "none"
			end

			hs.alert.show(output, hs.screen.mainScreen(), { textSize = 50 }, delay)
		end,
	},

	{
		key = "t",
		show = "🚀🐘",
		msg = "🚀 🐘 tailscale up (tufts)",
		cmd = tsb .. " up --exit-node=hadoop-prod-04 --exit-node-allow-lan-access",
	},

	{
		key = "w",
		show = "",
		msg = "switch",
		cmd = "",
		fn = function()
			local delay = 1
			local output, status = hs.execute("/Users/drio/.config/zsh/scripts/tsswitch")
			if not status then
				output = "Error running script"
			end

			hs.alert.show(output, hs.screen.mainScreen(), { textSize = 75 }, delay)
		end,
	},

	{
		key = "v",
		show = "",
		msg = "version",
		cmd = "",
		fn = function()
			local delay = 1
			local output, status = hs.execute("/Users/drio/.config/zsh/scripts/tScaleVCheck")
			if not status then
				output = "Error getting latest versions"
			end

			hs.alert.show(output, hs.screen.mainScreen(), { textSize = 75 }, delay)
		end,
	},
}

module.Load = function(hyper)
	spoon.ModalMgr.supervisor:bind(hyper, "i", "Enter ts Environment", function()
		spoon.ModalMgr:deactivateAll()
		spoon.ModalMgr:activate({ modalTS }, "#FF1493", false)
	end)

	spoon.ModalMgr:new(modalTS)
	local modal = spoon.ModalMgr.modal_list[modalTS]
	modal:bind("", "escape", "Deactivate modal TS", function()
		spoon.ModalMgr:deactivate({ "cmds" })
	end)
	modal:bind("", "Q", "Deactivate modal TS", function()
		spoon.ModalMgr:deactivate({ "cmds" })
	end)
	modal:bind("", "tab", "Toggle Cheatsheet TS", function()
		spoon.ModalMgr:toggleCheatsheet()
	end)

	common.setKeys(keys, modal)
end

return module
