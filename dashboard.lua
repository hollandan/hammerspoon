local log = hs.logger.new('dashboard','debug')
log.i('Initializing')

dashboard = hs.canvas.new({x=0, y=0, w=0, h=0}):show()
dashboard:behavior("canJoinAllSpaces")

dashboard[1] = {
    type = "rectangle",
    fillColor = {
        red      = 0,
        green    = 0,
        blue     = 0,
        alpha    = .6
    }
}
dashboard[2] = {
    type = "text",
    text = stamp,
    textFont = "DejaVu Sans Mono",
    textSize = 12,
    textColor = {hex="#ffffff"},
    textAlignment = "center"
}

local mainScreen = hs.screen.mainScreen()
local mainRes = mainScreen:fullFrame()
dashboard:frame({
    x = (mainRes.w-220),
    y = (mainRes.h-25),
    w = 220,
    h = 25
})

if clocktimer == nil then
    local clocktimer = hs.timer.doEvery(1, function()
        local stamp = hs.execute("date +'%m/%d | %a %I:%M:%S %p' | tr -d '\n'")
        log.i(stamp)
        dashboard[2].text = stamp
    end)
else
    clocktimer:start()
    dashboard:show()
end

-- Show/hide dashboard
hs.hotkey.bind(double_command, ';', function()
    if (dashboard:isVisible()) then
        dashboard:hide()
    else
        dashboard:show()
    end
end)
