hs.hotkey.bind(return_modifier, 'q', function()  mouseJump({x = 150, y = 150}) end)
hs.hotkey.bind(return_modifier, 'a', function()  mouseJump({x = 150, y = 450}) end)
hs.hotkey.bind(return_modifier, 'z', function()  mouseJump({x = 150, y = 700}) end)

hs.hotkey.bind(return_modifier, 'w', function()  mouseJump({x = 700, y = 150}) end)
hs.hotkey.bind(return_modifier, 'h', function()  mouseJump({x = 700, y = 450}) end)
hs.hotkey.bind(return_modifier, 'x', function()  mouseJump({x = 700, y = 700}) end)

hs.hotkey.bind(return_modifier, 'r', function()  mouseJump({x = 1200, y = 150}) end)
hs.hotkey.bind(return_modifier, "g", function()  mouseJump({x = 1200, y = 450}) end)
hs.hotkey.bind(return_modifier, 'c', function()  mouseJump({x = 1200, y = 700}) end)

hs.hotkey.bind(return_modifier, 'k', function()
    hs.eventtap.leftClick(hs.mouse.getAbsolutePosition())
end)

-- hs.hotkey.bind(return_modifier, 'f17', function()
hs.hotkey.bind(return_modifier, 'l', function()
    hs.eventtap.rightClick(hs.mouse.getAbsolutePosition())
end)

-- Use Karabiner the Elder to throw the cursor to the center of the currently focused window
hs.hotkey.bind(return_modifier, 'tab', function()
    os.execute('/Applications/Karabiner.app/Contents/Library/utilities/bin/warp-mouse-cursor-position front_window middle 0 center 0')
end)

-- smartZoom w/ BetterTouchTool
-- -- ({'alt, ctrl'}, 'f19')
