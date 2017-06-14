local hyperex = require('hyperex')

local rightCmd = hyperex.new('rightcmd')
-- local rightCmd = hyperex.new('f17')

-- syntax
-- -- hyperex:bind(key):to(key, {mods, ...})
-- -- hyperex:bind(key):to(function)
--
-- hyper + a -> b
-- hx:bind('a'):to('b')
-- hyper + ] -> shift + 8
-- hx:bind(']'):to('8', {'shift'})
-- hyper + z -> trigger function
-- hx:bind('z'):to(function() hs.eventtap.keyStroke({}, 'h') end)


-- this will exit navigationMode
rightCmd:setEmptyHitKey('f17')
-- rightCmd:setInitialKey('rightcmd')

rightCmd:bind('space'):to(function() invokeSpotlight() end)

-- normal cmd functions
rightCmd:bind('f'):to('f', {'cmd'})
rightCmd:bind('g'):to('g', {'cmd'})

rightCmd:bind('return'):to('return', {'cmd'})

-- Windows
rightCmd:bind('l'):to('`', {'cmd'})
rightCmd:bind(41):to('`', {'cmd', 'shift'})
rightCmd:bind('j'):to('f4', {'ctrl', 'fn'})
rightCmd:bind('k'):to('f4', {'ctrl', 'fn', 'shift'})
rightCmd:bind('c'):to(function() centerWindow() end)

-- Move window to adjacent space
rightCmd:bind('/'):to('pad2', {'cmd', 'alt', 'ctrl', 'shift'})
rightCmd:bind('f16'):to('pad3', {'cmd', 'alt', 'ctrl', 'shift'})


rightCmd:bind(','):to('f7', {'ctrl', 'fn'})

-- Throw cursor to notification
rightCmd:bind('\\'):to('\\', {'cmd', 'ctrl', 'alt'})


rightCmd:bind('z'):to(function() makeBagels() end)



function centerWindow()
    local win = hs.window.frontmostWindow()
    win:centerOnScreen("Color LCD")
end


function makeBagels()
    -- hs.alert.show("Yummy bagels yo")
    local ex = hs.expose.new()
    ex:show()
end

function invokeSpotlight()
    hs.eventtap.keyStroke({'cmd'}, 'space')
    navigationMode:exit()
end

-- rightCmd:bind('1'):to(function() nextWindowAndCenter() end)
-- function nextWindowAndCenter()
--     local firstWindow = hs.window.frontmostWindow()
--     local firstCoords = firstWindow:frame()
--
--     hs.alert.show(firstWindow:title())
--
--     hs.eventtap.keyStroke({'cmd'}, '`')
--
--     local nextWindow = hs.window.frontmostWindow()
--     local nextCoords = nextWindow:frame()
--
--     hs.alert.show(nextWindow:title())
--
--     nextWindow:setFrame(firstCoords)
--     firstWindow:setFrame(nextCoords)
-- end
