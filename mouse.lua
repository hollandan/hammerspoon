-- https://github.com/mgee/hammerspoon-config/blob/master/init.lua
function mouseNudge(offset)
    hs.mouse.setRelativePosition(hs.geometry(hs.mouse.getRelativePosition()):move(offset))
end
function mouseJump(offset)
    hs.mouse.setRelativePosition(hs.geometry(offset))
end

hs.hotkey.bind(return_modifier, 'q', function()  mouseJump({x = 150, y = 150}) end)
hs.hotkey.bind(return_modifier, 'a', function()  mouseJump({x = 150, y = 450}) end)
hs.hotkey.bind(return_modifier, 'z', function()  mouseJump({x = 150, y = 700}) end)

hs.hotkey.bind(return_modifier, 'e', function()  mouseJump({x = 700, y = 150}) end)
hs.hotkey.bind(return_modifier, 'd', function()  mouseJump({x = 700, y = 450}) end)
hs.hotkey.bind(return_modifier, 'x', function()  mouseJump({x = 700, y = 700}) end)

hs.hotkey.bind(return_modifier, 'r', function()  mouseJump({x = 1200, y = 150}) end)
hs.hotkey.bind(return_modifier, "f", function()  mouseJump({x = 1200, y = 450}) end)
hs.hotkey.bind(return_modifier, 'c', function()  mouseJump({x = 1200, y = 700}) end)

hs.hotkey.bind(return_modifier, 'l', function() mouseNudge({x =   0, y =  50}) end)
hs.hotkey.bind(return_modifier, 'o', function() mouseNudge({x =   0, y = -50}) end)
hs.hotkey.bind(return_modifier, 'k', function() mouseNudge({x = -50, y =   0}) end)
hs.hotkey.bind(return_modifier, ';', function() mouseNudge({x =  50, y =   0}) end)

-- hs.hotkey.bind(return_modifier, 'y', function() mouseNudge({x =   0, y =  10}) end)
-- hs.hotkey.bind(return_modifier, 'h', function() mouseNudge({x =   0, y = -10}) end)
-- hs.hotkey.bind(return_modifier, 'g', function() mouseNudge({x = -10, y =   0}) end)
-- hs.hotkey.bind(return_modifier, 'j', function() mouseNudge({x =  10, y =   0}) end)

hs.hotkey.bind(return_modifier, 'y', function() mouseNudge({x =   0, y =  10}) end)
hs.hotkey.bind(return_modifier, 'h', function() mouseNudge({x =   0, y = -10}) end)
hs.hotkey.bind(return_modifier, 'g', function() mouseNudge({x = -10, y =   0}) end)
hs.hotkey.bind(return_modifier, 't', function() mouseNudge({x =  10, y =   0}) end)

hs.hotkey.bind(return_modifier, 'space', function()
    hs.eventtap.leftClick(hs.mouse.getAbsolutePosition())
end)

hs.hotkey.bind(return_modifier, 'f17', function()
    hs.eventtap.rightClick(hs.mouse.getAbsolutePosition())
end)

-- Use Karabiner the Elder to throw the cursor to the center of the currently focused window
hs.hotkey.bind(return_modifier, 'tab', function()
    os.execute('/Applications/Karabiner.app/Contents/Library/utilities/bin/warp-mouse-cursor-position front_window middle 0 center 0')
end)

-- smartZoom w/ BetterTouchTool
-- -- ({'alt, ctrl'}, '9')
