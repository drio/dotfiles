require("hs.screen")
require("hs.timer")
require("hs.window")
require("hs.window.filter")

function invertScreen()
    hs.screen.setInvertedPolarity(true)
end

function normalScreen()
    hs.screen.setInvertedPolarity(false)
end

function nagScreen()
    -- start nagging
    local toggled = false
    local timer = hs.timer.doEvery(1, function()
        if toggled then
            normalScreen()
        else
            invertScreen()
        end
        toggled = not toggled
    end)

    local wf = hs.window.filter
    termWindow = wf.new("Terminal")
    termWindow:subscribe(wf.windowFocused, function()
        termWindow:unsubscribeAll()
        timer:stop()
        -- restore regardless of previous state.
        normalScreen()
    end)
end

