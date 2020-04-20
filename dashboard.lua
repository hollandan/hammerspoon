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
-- local mainRes = mainScreen:fullFrame()
local mainRes = hs.screen("Color LCD"):fullFrame()

local dashlength = 220
local dashheight = 24
dashboard:frame({
    x = (mainRes.w-dashlength),
    y = (mainRes.h-dashheight),
    w = dashlength,
    h = dashheight
})

if clocktimer == nil then
    clocktimer = hs.timer.doEvery(1, function()
        local remindfile = hs.execute("/bin/ls -tr /Users/dan/.config/remindme/ | head -n 1 | tr -d '\n'")
        local remindme  = hs.execute("cat /Users/dan/.config/remindme/".. remindfile .. " | tr -d '\n'")
        local stamp = hs.execute("date +'%I:%M:%S %p %a %m/%d' | tr -d '\n'")
        local battery = hs.execute("pmset -g batt | tail -1 | awk '{print $3,$4}' | sed 's/;/ :/' | sed 's/;//'")

        -- local denmark = hs.execute("date -v +'21600S' +'%I:%M:%S %p' | tr -d '\n'")
        -- local japan = hs.execute("date -v +'50400S' +'%I:%M:%S %p %a %m/%d' | tr -d '\n'")
        -- local portland = hs.execute("date -v -'10800S' +'%I:%M:%S %p %a %m/%d' | tr -d '\n'")

        local text = stamp
        -- local text = denmark .. " | " .. stamp
        -- local text = japan .. " | " .. stamp
        -- local text = portland .. " | " .. stamp

        if string.len(remindme) > 0 then
            text = remindme .. " ┃ " .. text
        end

        local percentage, powersource = battery:match("%s*(%d+)%%%s*:%s*(%a+)%s*")
        if powersource == "AC" and lastpercentage < percentage then
            dashboard[2].textColor = {hex="#ff0000"}
        end
        text = text .. " ┃ " .. battery
        lastpercentage = percentage

        dashboard[2].text = text

        local newdashlength = string.len(text)*8
        dashboard:frame({
            x = (mainRes.w-newdashlength),
            y = (mainRes.h-dashheight),
            w = newdashlength,
            h = dashheight
        })
    end)
else
    clocktimer:start()
    dashboard:show()
end

hs.hotkey.bind(double_command, "'", function()
    if (dashboard:isVisible()) then
        dashboard:hide()
    else
        dashboard:show()
    end
end)
