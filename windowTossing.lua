-- shamelessly stolen from Greg Hurrel
-- -- https://github.com/wincent/wincent/tree/35d430520d525e8ac4c829f4436e5b42c8df5dd8/roles/dotfiles/files/.hammerspoon
-- and of course modified for my own purposes
local lastSeenChain = nil
local lastSeenWindow = nil

-- Chain the specified movement commands.
--
-- This is like the "chain" feature in Slate, but with a couple of enhancements:
--
--  - Chains always start on the screen the window is currently on.
--  - A chain will be reset after 2 seconds of inactivity, or on switching from
--    one chain to another, or on switching from one app to another, or from one
--    window to another.
--
chain = (function(movements)
  local chainResetInterval = 2 -- seconds
  local cycleLength = #movements
  local sequenceNumber = 1

  return function()
    local win = hs.window.frontmostWindow()
    local id = win:id()
    local now = hs.timer.secondsSinceEpoch()
    local screen = win:screen()

    if
      lastSeenChain ~= movements or
      lastSeenAt < now - chainResetInterval or
      lastSeenWindow ~= id
    then
      sequenceNumber = 1
      lastSeenChain = movements
    elseif (sequenceNumber == 1) then
      -- At end of chain, restart chain on next screen.
      screen = screen:next()
    end
    lastSeenAt = now
    lastSeenWindow = id

    hs.grid.set(win, movements[sequenceNumber], screen)
    sequenceNumber = sequenceNumber % cycleLength + 1
  end
end)

-- hs.hotkey.bind(right_command, 'f', chain({
--     grid.fullScreen
-- }))

hs.hotkey.bind(right_command, 'a', chain({
  grid.leftHalf,
  grid.leftThird,
  grid.leftTwoThirds,
}))

hs.hotkey.bind(right_command, "\'", chain({
  grid.rightHalf,
  grid.rightThird,
  grid.rightTwoThirds,
}))

hs.hotkey.bind(right_command, 'r', chain({
  grid.topHalf,
  grid.topThird,
  grid.topTwoThirds,
}))


hs.hotkey.bind(right_command, 'm', chain({
  grid.bottomHalf,
  grid.bottomThird,
  grid.bottomTwoThirds,
}))


hs.hotkey.bind(right_command, 'q', chain({
  grid.topLeft,
  grid.topLeftSplitTop,
  grid.topLeftSplitBottom
}))

hs.hotkey.bind(right_command, 'z', chain({
  grid.bottomLeft,
  grid.bottomLeftSplitTop,
  grid.bottomLeftSplitBottom
}))

hs.hotkey.bind(right_command, 'p', chain({
  grid.topRight,
  grid.topRightSplitTop,
  grid.topRightSplitBottom
}))

hs.hotkey.bind(right_command, '/', chain({
  grid.bottomRight,
  grid.bottomRightSplitTop,
  grid.bottomRightSplitBottom
}))


hs.hotkey.bind(right_command, ',', chain({
  grid.fullScreen,
  grid.centeredBig,
  grid.centeredSmall,
}))

-- stolen and modified from https://github.com/cmsj/hammerspoon-config/blob/master/init.lua
function toggleWindowMaximized()
    local win = hs.window.focusedWindow()
    if frameCache[win:id()] then
        win:setFrame(frameCache[win:id()])
        frameCache[win:id()] = nil
    else
        frameCache[win:id()] = win:frame()
        win:maximize()
    end
end
function toggleCenterWindow()
    local win = hs.window.focusedWindow()
    if frameCache[win:id()] then
        win:setFrame(frameCache[win:id()])
        frameCache[win:id()] = nil
    else
        frameCache[win:id()] = win:frame()
        win:centerOnScreen("Color LCD")
    end
end

hs.hotkey.bind(right_command, 'c', function()
    toggleCenterWindow()
end)
hs.hotkey.bind(right_command, 'f', function()
    toggleWindowMaximized()
end)

hs.hotkey.bind(right_command, 'd', function()
    showDesktop()
end)

hs.hotkey.bind(right_command, 'w', function()
    showApplicationWindows()
end)

function showApplicationWindows()
    fastKeyStroke({'cmd', 'alt', 'ctrl', 'shift'}, 'f10')
    -- local currentapp = hs.application.frontmostApplication();
    -- hs.alert.show(currentapp)
    functionMode:exit()
    navigationMode:enter()
end
function showDesktop()
    functionMode:exit()
    fastKeyStroke({'cmd', 'alt', 'ctrl', 'shift'}, 'f11')

    -- if the current app is finder
        -- hit command tab to go back to original app
    -- else, tell application finder to activate
    -- local currentapp = hs.application.frontmostApplication();
    -- hs.alert.show(currentapp)
    -- if string.find(currentapp, 'Finder') then
    --     hs.applescript.applescript([[
    --         tell application "Finder" to activate
    --     ]])
    -- else
    --     hs.eventtap.keyStroke({'cmd'}, 'tab')
    -- end
end

hs.hotkey.bind(right_command, 'tab', function()
    os.execute('/Applications/Karabiner.app/Contents/Library/utilities/bin/warp-mouse-cursor-position front_window middle 0 center 0')
end)
