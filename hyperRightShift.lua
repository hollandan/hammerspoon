local hyperex = require('hyperex')
local rightShift = hyperex.new('f16')

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


rightShift:setEmptyHitKey('escape')
rightShift:bind('l'):to('l', {'shift'})

rightShift:bind('/'):to(function() openStatusMenu() end)
rightShift:bind('z'):to('f2', {'ctrl', 'fn'})

rightShift:bind('r'):to(function() hs.eventtap.keyStroke({}, 'h') end)

function openStatusMenu()
    hs.eventtap.keyStroke({'ctrl', 'fn'}, "f8")
    hs.eventtap.keyStroke({}, "f19")
end
