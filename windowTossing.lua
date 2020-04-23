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
    sequenceNumber = sequenceNumber % cycleLength + 1
    redrawBorder()
    -- make cursor center in active window 
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
  grid.allPad,
  grid.wideVertical,
  grid.tallHorizontal,
}))


-- https://github.com/Hammerspoon/hammerspoon/issues/835

hs.hotkey.bind(right_command, "u", function ()
    focusScreen(hs.window.focusedWindow():screen():next())
end)

--Predicate that checks if a window belongs to a screen
function isInScreen(screen, win)
    return win:screen() == screen
end

function focusScreen(screen)
    --Get windows within screen, ordered from front to back.
    --If no windows exist, bring focus to desktop. Otherwise, set focus on
    --front-most application window.
    local windows = hs.fnutils.filter(
    hs.window.orderedWindows(),
    hs.fnutils.partial(isInScreen, screen))
    local windowToFocus = #windows > 0 and windows[1] or hs.window.desktop()
    windowToFocus:focus()

    -- Move mouse to center of screen
    local pt = hs.geometry.rectMidPoint(screen:fullFrame())
    hs.mouse.setAbsolutePosition(pt)
end


-- stolen and modified from https://github.com/cmsj/hammerspoon-config/blob/master/init.lua
function toggleWindowMaximized()
    local win = hs.window.focusedWindow()

    if string.match(win:application():name() , 'iTerm2') then
        hs.eventtap.keyStroke({'cmd'}, 'return')
    else
        if identifyFocusedWindowLocation().fullscreen then
            snapBack()
        else
            fullFrameCache[win:id()] = win:frame()
            win:maximize()
        end
    end

    redrawBorder()

end
function toggleCenterWindow()
    local win = hs.window.focusedWindow()
    -- win:centerOnScreen(hs.screen.mainScreen())

    -- w = identifyFocusedWindowLocation()
    -- if w.left or w.right then
    --     if w.fullwidth and (not w.top and not w.bottom) then
    --         snapBack()
    --     else

            centeredFrameCache[win:id()] = win:frame()
            win:centerOnScreen(hs.screen.mainScreen())

    --     end
    -- else
    --     snapBack()
    -- end

    redrawBorder()
end
function snapBack()
    local win = hs.window.frontmostWindow()

    if centeredFrameCache[win:id()] then
        win:setFrame(centeredFrameCache[win:id()])
        centeredFrameCache[win:id()] = nil
    elseif fullFrameCache[win:id()] then
        win:setFrame(fullFrameCache[win:id()])
        fullFrameCache[win:id()] = nil
    end
end

function decreaseWindowHeight()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.h = f.h - f.h*.25
  win:setFrame(f)
end

function increaseWindowHeight()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.h = f.h + f.h*.25
  win:setFrame(f)
end

function decreaseWindowWidth()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.w = f.w - f.w*.25
  win:setFrame(f)
end
function increaseWindowWidth()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.w = f.w + f.w*.25
  win:setFrame(f)
end

function nudgeWindowUp()
    local f = hs.window.focusedWindow():frame()
    local win = hs.window.focusedWindow()
    local f = win:frame()

    f.y = f.y - 10
    win:setFrame(f)
end

function nudgeWindowDown()
    local f = hs.window.focusedWindow():frame()
    local win = hs.window.focusedWindow()
    local f = win:frame()

    f.y = f.y + 10
    win:setFrame(f)
end

function nudgeWindowRight()
    local f = hs.window.focusedWindow():frame()
    local win = hs.window.focusedWindow()
    local f = win:frame()

    f.x = f.x + 10
    win:setFrame(f)
end

function nudgeWindowLeft()
    local f = hs.window.focusedWindow():frame()
    local win = hs.window.focusedWindow()
    local f = win:frame()

    f.x = f.x - 10
    win:setFrame(f)
end

hs.hotkey.bind({}, 'pad3', function()
    nudgeWindowUp()
end)
hs.hotkey.bind({}, 'pad4', function()
    nudgeWindowDown()
end)
hs.hotkey.bind({}, 'pad5', function()
    nudgeWindowLeft()
end)
hs.hotkey.bind({}, 'pad6', function()
    nudgeWindowRight()
end)

hs.hotkey.bind({"shift"}, 'pad3', function()
    nudgeWindowUp()
    nudgeWindowUp()
    nudgeWindowUp()
end)
hs.hotkey.bind({"shift"}, 'pad4', function()
    nudgeWindowDown()
    nudgeWindowDown()
    nudgeWindowDown()
end)
hs.hotkey.bind({"shift"}, 'pad5', function()
    nudgeWindowLeft()
    nudgeWindowLeft()
    nudgeWindowLeft()
end)
hs.hotkey.bind({"shift"}, 'pad6', function()
    nudgeWindowRight()
    nudgeWindowRight()
    nudgeWindowRight()
end)



hs.hotkey.bind(right_command, 't', function()
    changeSizeTowardTop()
end)

hs.hotkey.bind(right_command, 'n', function()
    changeSizeTowardBottom()
end)

hs.hotkey.bind(right_command, 'h', function()
    changeSizeTowardLeft()
end)

hs.hotkey.bind(right_command, 'g', function()
    changeSizeTowardRight()
end)


function changeSizeTowardTop()
    local rect = identifyFocusedWindowLocation()
    if rect.top then
        decreaseWindowHeight()
    elseif rect.bottom then
        increaseWindowHeightAndHugBottom()
    else
        decreaseWindowHeightAndHugBottom()
    end
    redrawBorder()
end

function changeSizeTowardRight()
    local amethyst = hs.execute("ps aux | grep Amethyst | wc -l | tr -d ' '")

    if (tonumber(amethyst) < 3) then
        local rect = identifyFocusedWindowLocation()
        if rect.right then
            decreaseWindowWidthAndHugRightSide()
        else
            increaseWindowWidth()
        end
        redrawBorder()
    else
        hs.eventtap.keyStroke({'alt', 'shift'}, 'l')
    end

end

function changeSizeTowardBottom()
    local rect = identifyFocusedWindowLocation()
    if (rect.bottom) then
        decreaseWindowHeightAndHugBottom()
    else
        increaseWindowHeightAndHugBottom()
    end
    redrawBorder()
end

function changeSizeTowardLeft()

    local amethyst = hs.execute("ps aux | grep Amethyst | wc -l | tr -d ' '")

    if (tonumber(amethyst) < 3) then
        local rect = identifyFocusedWindowLocation()
        if rect.left then
            decreaseWindowWidth()
        elseif rect.right then
            increaseWindowWidthAndHugRightSide()
        else
            decreaseWindowWidth()
        end
        redrawBorder()
    else
        hs.eventtap.keyStroke({'alt', 'shift'}, 'h')
    end

end



function decreaseWindowWidthAndHugRightSide()
    local win = hs.window.focusedWindow()
    local f = win:frame()

    oldfw = f.w
    newfw = math.floor(f.w - f.w*.25)
    f.w = newfw

    if math.floor(oldfw - f.w) == 0 then
        deltax = 0
    else
        deltax = oldfw - newfw
    end

    w = identifyFocusedWindowLocation()
    if w.right then
        local screen = win:screen()
        local max = screen:frame()

        if f.x + f.w < max.w then
            f.x = f.x + deltax
        end
    end

    win:setFrame(f)
    stayInBounds()
end

function increaseWindowWidthAndHugRightSide()
    local win = hs.window.focusedWindow()
    local f = win:frame()

    local newfw = math.floor(f.w + f.w*.25)
    local deltax = math.floor(f.w - newfw)
    f.w = newfw

    f.x = f.x + deltax

    win:setFrame(f)
    stayInBounds()
end

function stayInBounds()
    local rect=identifyFocusedWindowLocation()

    if rect.tooright then
        local f = win:frame()
        f.x = f.x + rect.rightoffset
        win:setFrame(f)
    end

    if rect.tooleft then
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()
        f.x = 0
        f.w = max.w
        win:setFrame(f)
    end

    if rect.toolow then
        local f = win:frame()
        f.y = f.y + rect.bottomoffset
        win:setFrame(f)
    end

end

function decreaseWindowHeightAndHugBottom()
    local win = hs.window.focusedWindow()
    local f = win:frame()

    local oldfh = f.h
    local newfh = math.floor(f.h - f.h*.25)
    local deltay = math.floor(f.h - newfh)

    if newfh == oldfh then
        hs.alert.show("size did not change")
    end

    f.h = newfh
    w = identifyFocusedWindowLocation()
    if w.bottom then
        f.y = f.y + deltay
    end

    win:setFrame(f)
    keepBottom()
end

function increaseWindowHeightAndHugBottom()
    local win = hs.window.focusedWindow()
    local f = win:frame()

    local oldfh = f.h
    local newfh = math.floor(f.h + f.h*.25)
    local deltay = math.floor(f.h - newfh)

    if newfh == oldfh then
        hs.alert.show("size did not change")
    end
    f.h = newfh

    w = identifyFocusedWindowLocation()
    if w.bottom then
        f.y = f.y + deltay
    end

    win:setFrame(f)
    keepBottom()
end

function keepBottom()
    local rect=identifyFocusedWindowLocation()
    if rect.toolow then
        local f = win:frame()
        f.y = f.y + rect.bottomoffset
        win:setFrame(f)
    end
end

-- Toggle Center And Zoom
hs.hotkey.bind(double_command, 'space', function()
    local win = hs.window.focusedWindow()
    if centeredFrameCache[win:id()] then
        win:setFrame(centeredFrameCache[win:id()])
        centeredFrameCache[win:id()] = nil
    else
        centeredFrameCache[win:id()] = win:frame()
        hs.grid.set(win, grid.centeredBig, win:screen())
    end
    hs.eventtap.keyStroke({'cmd', 'alt'}, '8')
end)


hs.hotkey.bind(right_command, 'c', function()
    toggleCenterWindow()
end)
hs.hotkey.bind(right_command, 'f', function()
    toggleWindowMaximized()
end)
hs.hotkey.bind(right_command, 'b', function()
    snapBack()
end)

hs.hotkey.bind(right_command, 'd', function()
    showDesktop()
end)

hs.hotkey.bind(double_command, 'w', function()
    showApplicationWindows()
    navigationMode:enter()
end)

function showApplicationWindows()
    -- Systemwide keystoke set in System Preferences to Show Application Windows
    fastKeyStroke({'cmd', 'alt', 'ctrl', 'shift'}, 'f10')
    functionMode:exit()
    navigationMode:enter()
end
function showDesktop()
    functionMode:exit()

    -- Systemwide keystoke set in System Preferences to Show Desktop
    fastKeyStroke({'cmd', 'alt', 'ctrl', 'shift'}, 'f11')

    -- Show Desktop is kind of stupid in that it does not automatically change
    -- the current app to the Finder
    if (string.match(currentapp:name(), 'Finder')) then
        -- so, if we're in the finder, cmd-tab back from where we came
        hs.eventtap.keyStroke({'cmd'}, 'tab')
    else
        -- otherwise, set the current app to the finder, so we can manipulate
        -- the desktop with the keyboard
        hs.osascript.applescript([[
            tell application "Finder" to activate desktop
        ]])
    end

end

function identifyFocusedWindowLocation()
    local externalmonitor
    local f = hs.window.focusedWindow():frame()
    local max = win:screen():frame()

    local p = {}
    p["top"]        = false
    p["left"]       = false
    p["right"]      = false
    p["bottom"]     = false
    p["fullwidth"]  = false
    p["fullheight"] = false
    p["fullscreen"] = false
    p["leftoffset"] = 0
    p["rightoffset"] = 0
    p["bottomoffset"] = 0

    if f.x < 0 or f.y < 0 then
        externalmonitor  = TRUE
        local falsewidth = 1690.0
        local falseleft  = -230.0
        local falsetop   = -1080.0

        if f.x == falseleft        then p["left"]   = true end
        if f.y == falsetop         then p["top"]    = true end
        if math.abs(f.x) + math.abs(f.w) == falsewidth then p["right"] = true end
        if math.abs(math.abs(f.h) - math.abs(f.y)) <= 5 then p["bottom"] = true end

    else
        externalmonitor = FALSE

        if f.x == 0.0              then p["left"]   = true end
        if f.y == 0.0              then p["top"]    = true end
        if f.x + f.w >= max.w - hs.grid.MARGINX  then p["right"]  = true end
        if f.y + f.h >= max.h - hs.grid.MARGINY  then p["bottom"] = true end
        -- may need to subtract another 5 above because sometimes windows
        -- won't quite reach the edge...

        if f.x < 0.0               then p["tooleft"] = true end
        if f.x + f.w > max.w       then p["tooright"] = true end
        if f.y + f.h > max.h       then p["toolow"]  = true end

        if f.x < 0.0               then p["leftoffset"] = f.x end
        if f.x + f.w > max.w       then p["rightoffset"] = max.w - (f.x + f.w) end
        if f.y + f.h > max.h       then p["bottomoffset"] = max.h - (f.y + f.h) end

        if p["top"] and p["bottom"]           then p["fullheight"] = true end
        if p["left"] and p["right"]           then p["fullwidth"]  = true end
        if p["fullwidth"] and p["fullheight"] then p["fullscreen"] = true end
    end

    return p;
end

hs.hotkey.bind(right_command, '1', function() windowInfo() end)

function windowInfo()

    local f = hs.window.focusedWindow():frame()
    local max = win:screen():frame()

    hs.alert.show(win:title())
    hs.alert.show(win:application():name())
    hs.alert.show("Max   : " .. max.w .. "W x " .. max.h .."H")
    hs.alert.show("Window: " .. f.w .. "W x " .. f.h .. "H")
    hs.alert.show("Pos   : " .. f.x .. "X x " .. f.y .. "Y")

    local rect = identifyFocusedWindowLocation()
    if rect.top then hs.alert.show("top") end
    if rect.right then hs.alert.show("right") end
    if rect.bottom then hs.alert.show("bottom") end
    if rect.left then hs.alert.show("left") end
    -- if rect.fullwidth then hs.alert.show("fullwidth") end
    -- if rect.fullheight then hs.alert.show("fullheight") end
    -- if rect.fullscreen then hs.alert.show("fullscreen") end
    -- if rect.toolow then hs.alert.show("tooLow") end
    -- if rect.tooleft then hs.alert.show("tooLeft") end
    -- if rect.tooright then hs.alert.show("tooRight") end

    if rect.toolow then hs.alert.show("low: " .. rect.bottomoffset) end
    if rect.tooleft then hs.alert.show("left: " .. rect.leftoffset) end
    if rect.tooright then hs.alert.show("right: " .. rect.rightoffset) end

    if f.x < 0 or f.y < 0 then hs.alert.show("top monitor") end
    if f.x > 0 and f.y > 0 then hs.alert.show("lap monitor") end

end

-- hs.hotkey.bind(right_command, '2', function()
    -- hs.grid.resizeWindowShorter(hs.window.focusedWindow())
    -- hs.grid.pushWindowUp(hs.window.focusedWindow())
    -- hs.grid.snap(hs.window.focusedWindow())
    -- hs.grid.show()
    -- hs.grid.adjustWidth(10)
-- end)

-- command list


hs.hotkey.bind(right_command, "4", function() hs.fnutil.map(hs.window.visibleWindows(), hs.grid.snap) end)
hs.hotkey.bind(right_command, '=', function() hs.grid.adjustWidth( 1) end)


-- Below in development
hs.hotkey.bind(right_command, '-', function()
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


-- Choices
--
-- increaseWindowHeight()
-- increaseWindowWidth()
-- increaseWindowHeightAndHugBottom()
-- increaseWindowWidthAndHugRightSide()
--
-- decreaseWindowHeight()
-- decreaseWindowWidth()
-- decreaseWindowHeightAndHugBottom()
-- decreaseWindowWidthAndHugRightSide()
--
-- nudgeWindowUp()
-- nudgeWindowRight()
-- nudgeWindowDown()
-- nudgeWindowLeft()
--
-- changeSizeTowardTop()
-- changeSizeTowardRight()
-- changeSizeTowardBottom()
-- changeSizeTowardLeft()

hs.hotkey.bind(right_command, '3', function()
    nudgeWindowUp()
    nudgeWindowLeft()
    changeSizeTowardRight()
    changeSizeTowardBottom()
end)
