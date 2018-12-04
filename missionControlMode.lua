-- missionControlMode = hs.hotkey.modal.new(double_command, 'return')
missionControlMode = hs.hotkey.modal.new(double_command, 'r')
missionControlMode:bind({}      , 'escape', function() missionControlMode:exit() end)
missionControlMode:bind({}      , 'eisu', function() missionControlMode:exit() end)
missionControlMode:bind({}      , 'return' , function() missionControlMode:exit() end)
missionControlMode:bind({}      , 'space' , function() missionControlMode:exit() end)
missionControlMode:bind({'ctrl'}, 'space' , function() missionControlMode:exit() end)

missionControlMode:bind({}, 'q' , function() missionControlMode:exit() end)
missionControlMode:bind({}, 'w' , function() missionControlMode:exit() end)
missionControlMode:bind({}, 'e' , function() missionControlMode:exit() end)
missionControlMode:bind({}, 'r' , function() missionControlMode:exit() end)
missionControlMode:bind({}, 't' , function() missionControlMode:exit() end)
missionControlMode:bind({}, 'y' , function() missionControlMode:exit() end)
missionControlMode:bind({}, 'u' , function() missionControlMode:exit() end)
missionControlMode:bind({}, 'i' , function() missionControlMode:exit() end)
missionControlMode:bind({}, 'o' , function() missionControlMode:exit() end)
missionControlMode:bind({}, 'p' , function() missionControlMode:exit() end)

missionControlMode:bind({}, 'a' , function() goToDesktopOne() end)
missionControlMode:bind({}, 's' , function() goToDesktopTwo() end)
missionControlMode:bind({}, 'd' , function() goToDesktopThree() end)
missionControlMode:bind({}, 'f' , function() goToDesktopFour() end)
missionControlMode:bind({}, 'g' , function() missionControlMode:exit() end)
missionControlMode:bind({}, 'h' , function() missionControlMode:exit() end)
missionControlMode:bind({}, 'j' , function() goDesktopLeft() end)
missionControlMode:bind({}, 'k' , function() missionControlMode:exit() end)
missionControlMode:bind({}, 'l' , function() missionControlMode:exit() end)
missionControlMode:bind({}, ';' , function() goDesktopRight() end)

missionControlMode:bind({}, 'z' , function() missionControlMode:exit() end)
missionControlMode:bind({}, 'x' , function() missionControlMode:exit() end)
missionControlMode:bind({}, 'c' , function() missionControlMode:exit() end)
missionControlMode:bind({}, 'v' , function() missionControlMode:exit() end)
missionControlMode:bind({}, 'b' , function() missionControlMode:exit() end)
missionControlMode:bind({}, 'n' , function() missionControlMode:exit() end)
missionControlMode:bind({}, 'm' , function() missionControlMode:exit() end)
missionControlMode:bind({}, ',' , function() missionControlMode:exit() end)
missionControlMode:bind({}, '.' , function() missionControlMode:exit() end)
missionControlMode:bind({}, '/' , function() missionControlMode:exit() end)

function missionControlMode:entered()
    fastKeyStroke({'cmd', 'alt', 'ctrl', 'shift'}, 'f9')
    mouseJump({x = 750, y = 40})
    mouseNudge({x = -20, y = -20})

    currentColor = missionControlColor
    if currentIndicator ~= nil then
        currentIndicator:setStrokeColor(currentColor)
    end

    dashboard[1] = {
        type = "rectangle",
        fillColor = missionControlColor
    }
end

function missionControlMode:exited()
    fastKeyStroke({}, "escape")
    currentColor = focusedColor
    if currentIndicator ~= nil then
        currentIndicator:setStrokeColor(currentColor);
    end
    dashboard[1] = {
        type = "rectangle",
        fillColor = darkColor
    }
end


function goToDesktopOne()
    fastKeyStroke(double_command, 'a')
end

function goToDesktopTwo()
    fastKeyStroke(double_command, 's')
end

function goToDesktopThree()
    fastKeyStroke(double_command, 'd')
end

function goToDesktopFour()
    fastKeyStroke(double_command, 'f')
end

function goDesktopLeft()
    fastKeyStroke(double_command, 'j')
end

function goDesktopRight()
    fastKeyStroke(double_command, ';')
end

-- function invokeITerm()
--     missionControlMode:exit()
--     fastKeyStroke({'ctrl'}, 'space')
--     fastKeyStroke({'ctrl'}, 'space')
-- end
