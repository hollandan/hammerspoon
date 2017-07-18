-- chain functionality shamelessly stolen from Greg Hurrel
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
    redrawBorder()
    sequenceNumber = sequenceNumber % cycleLength + 1
  end
end)

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
  grid.bottomThird,
  grid.bottomHalf,
  grid.bottomTwoThirds,
}))


hs.hotkey.bind(right_command, 'q', chain({
  grid.topLeft,
  grid.topLeftSplitTop,
  grid.topLeftSplitBottom
}))

hs.hotkey.bind(right_command, 'z', chain({
  grid.bottomLeft,
  grid.bottomLeftSplitBottom,
  grid.bottomLeftSplitTop,
}))

hs.hotkey.bind(right_command, 'p', chain({
  grid.topRight,
  grid.topRightSplitTop,
  grid.topRightSplitBottom
}))

hs.hotkey.bind(right_command, '/', chain({
  grid.bottomRight,
  grid.bottomRightSplitBottom,
  grid.bottomRightSplitTop,
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
    redrawBorder()
end
function toggleCenterWindow()
    local win = hs.window.focusedWindow()
    if frameCache[win:id()] then
        win:setFrame(frameCache[win:id()])
        frameCache[win:id()] = nil
    else
        frameCache[win:id()] = win:frame()
        win:centerOnScreen('Color LCD')
    end
    redrawBorder()
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

-- Essentially: right_command+left_command
hs.hotkey.bind({'ctrl', 'alt', 'shift', 'cmd'}, 'w', function()
    showApplicationWindows()
end)

function showApplicationWindows()
    -- Systemwide keystoke I set in System Preferences to Show Application Windows
    fastKeyStroke({'cmd', 'alt', 'ctrl', 'shift'}, 'f10')
    functionMode:exit()
    navigationMode:enter()
end
function showDesktop()
    functionMode:exit()
    -- Systemwide keystoke I set in System Preferences to Show Desktop
    fastKeyStroke({'cmd', 'alt', 'ctrl', 'shift'}, 'f11')

    -- Show Desktop is kind of stupid in that it does not automatically change
    -- the current app to the Finder
    local currentapp = hs.application.frontmostApplication();
    if (string.match(currentapp:name(), 'Finder')) then
        -- so, if we're in the finder, cmd-tab back from where we came
        hs.eventtap.keyStroke({'cmd'}, 'tab')
    else
        -- otherwise, set the current app to the finder, so we can manipulate
        -- the desktop with the keyboard
        hs.applescript.applescript([[
            tell application "Finder" to activate
        ]])
    end
end

-- Below in development
hs.hotkey.bind(right_command, 'g', function()
    markWindow()
end)
function markWindow()
    local win = hs.window.focusedWindow()
    if markedFrameCache[win:id()] then
        -- win:setFrame(frameCache[win:id()])
        -- remove mark
        markedFrameCache[win:id()] = nil
        border:delete()
    else
        -- add mark
        markedFrameCache[win:id()] = win:frame()
        -- shamelessly stolen from https://gist.github.com/koekeishiya/dc48db74f4fdbfbf5648
        local f = win:frame()
        local fx = f.x - 2
        local fy = f.y - 2
        local fw = f.w + 4
        local fh = f.h + 4

        border = hs.drawing.rectangle(hs.geometry.rect(fx, fy, fw, fh))
        border:setStrokeWidth(3)
        border:setStrokeColor({['red']=0.75,['blue']=0.14,['green']=0.83,['alpha']=0.80})
        border:setRoundedRectRadii(5.0, 5.0)
        border:setStroke(true):setFill(false)
        border:setLevel('floating')
        border:show()
    end
end

hs.hotkey.bind(right_command, 'y', function()
    identifyMarkedWindows()
end)
function identifyMarkedWindows()
    for id,win in pairs(markedFrameCache) do
        hs.alert.show(id)
        hs.alert.show(win)
    end
end
