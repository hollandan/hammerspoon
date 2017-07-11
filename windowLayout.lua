local topHalf            = hs.geometry.rect(0   , 0   , 1500 , 450)
local bottomHalf         = hs.geometry.rect(0   , 450 , 1500 , 450)
local topLeftQuarter     = hs.geometry.rect(0   , 0   , 750  , 450)
local topRightQuarter    = hs.geometry.rect(750 , 0   , 750  , 450)
local bottomLeftQuarter  = hs.geometry.rect(0   , 450 , 750  , 450)
local bottomRightQuarter = hs.geometry.rect(750 , 450 , 750  , 450)

local topThird           = hs.geometry.rect(0   , 0   , 1500 , 600)
local bottomLeftThird    = hs.geometry.rect(0   , 600 , 750  , 300)
local bottomRightThird   = hs.geometry.rect(750 , 600 , 750  , 300)

local laptopScreen = 'Color LCD'

local balanceFlag = false
local alterFlag = false

hs.hotkey.bind({}, 'pad0', function()
    balanceWindows()
end)
hs.hotkey.bind({}, 'pad1', function()
    alterWindows()
end)

windowList = function() getWindowList() end

function getWindowList()
    local windows = hs.window.allWindows()
    windowlist = {}
    for _,win in pairs(windows) do
        -- hs.alert.show(win:id() .. ': ' .. win:title() .. ' | ' .. win:application():name())
        local app = win:application():name()
        if (app == 'SimpleFloatingClock') then
            -- hs.alert.show('clock')
        elseif (app == 'Hammerspoon') then
            -- hs.alert.show('spoon')
        elseif (app == 'iTerm2') then
            -- hs.alert.show('term')
        else
            table.insert(windowlist, win)
        end
    end

    return windowlist
end

function showWindowList()
    for _,win in pairs(windowList) do
        hs.alert.show(win:id() .. ': ' .. win:title() .. ' | ' .. win:application():name())
    end
end

function balanceWindows()

    balanceFlag = true
    alterFlag = false


    local appWindows = getAppWindows()
    local count = #appWindows
 
    hs.eventtap.keyStroke({'cmd'}, '`')

    if (count == 1) then

        local oneWindow = {
            {thisapp, nil, laptopScreen, hs.layout.maximized, nil, nil}
        }
        hs.layout.apply(oneWindow)

    elseif (count == 2) then

        local twoWindows = {
            {thisapp, appWindows[1]:title(), laptopScreen, hs.layout.left50, nil, nil},
            {thisapp, appWindows[2]:title(), laptopScreen, hs.layout.right50, nil, nil}
        }
        hs.layout.apply(twoWindows)

    elseif (count == 3) then

        local threeWindows = {
            {thisapp, appWindows[1]:title(), laptopScreen, nil, nil, bottomRightQuarter},
            {thisapp, appWindows[2]:title(), laptopScreen, nil, nil, bottomLeftQuarter},
            {thisapp, appWindows[3]:title(), laptopScreen, nil, nil, topHalf}
        }
        hs.layout.apply(threeWindows)

    elseif (count == 4) then

        local fourWindows = {
            {thisapp, appWindows[1]:title(), laptopScreen, nil, nil, topLeftQuarter},
            {thisapp, appWindows[2]:title(), laptopScreen, nil, nil, topRightQuarter},
            {thisapp, appWindows[3]:title(), laptopScreen, nil, nil, bottomLeftQuarter},
            {thisapp, appWindows[4]:title(), laptopScreen, nil, nil, bottomRightQuarter}
        }
        hs.layout.apply(fourWindows)

    end

end

function getAppWindows()
    windowList = getWindowList()

    local count = 0
    local appWindows = {}
    local currentWindow = hs.window.frontmostWindow()
    local thisapp = currentWindow:application():name()

    for _,win in pairs(windowList) do
        if (win:application():name() == thisapp) then
            count = count + 1
            table.insert(appWindows, win)
        end
    end

    return appWindows
end

function alterWindows()
    balanceFlag = false
    alterFlag   = true

    local appWindows = getAppWindows()
    local count = #appWindows
 
    hs.eventtap.keyStroke({'cmd'}, '`')

    if (count == 1) then

        local oneWindow = {
            {thisapp, nil, laptopScreen, hs.layout.maximized, nil, nil}
        }
        hs.layout.apply(oneWindow)

    elseif (count == 2) then

        local twoWindows = {
            {thisapp, appWindows[1]:title(), laptopScreen, nil, nil, topHalf},
            {thisapp, appWindows[2]:title(), laptopScreen, nil, nil, bottomHalf}
        }
        hs.layout.apply(twoWindows)

    elseif (count == 3) then

        local threeWindows = {
            {thisapp, appWindows[1]:title(), laptopScreen, nil, nil, bottomRightThird},
            {thisapp, appWindows[2]:title(), laptopScreen, nil, nil, bottomLeftThird},
            {thisapp, appWindows[3]:title(), laptopScreen, nil, nil, topThird}
        }
        hs.layout.apply(threeWindows)

    elseif (count == 4) then

        local fourWindows = {
            {thisapp, appWindows[1]:title(), laptopScreen, nil, nil, topLeftQuarter},
            {thisapp, appWindows[2]:title(), laptopScreen, nil, nil, topRightQuarter},
            {thisapp, appWindows[3]:title(), laptopScreen, nil, nil, bottomLeftQuarter},
            {thisapp, appWindows[4]:title(), laptopScreen, nil, nil, bottomRightQuarter}
        }
        hs.layout.apply(fourWindows)

    end

end


hs.hotkey.bind({'cmd', 'ctrl'}, 'z', function()
    resizeLayout()
end)

hs.hotkey.bind({'cmd', 'ctrl'}, 'x', function()
    resizeLayoutReverse()
end)

function resizeLayout()
    local count = 0
    local appWindows = {}

    local appWindows = getAppWindows()
    local count = #appWindows

    if (balanceFlag) then
        -- hs.alert.show('balance')
        if (count == 2) then
            local other = appWindows[2]
            local op    = appWindows[1]

            local fop = op:frame()
            local fother = other:frame()
            local screen = op:screen():frame()

            fop.w = fop.w+20
            fother.w = fother.w-20
            fop.x = screen.w - fop.w

            op:setFrame(fop)
            other:setFrame(fother)
        end
    end
    if (alterFlag) then
        -- hs.alert.show('alter')
        if (count == 2) then
            local other = appWindows[2]
            local op    = appWindows[1]

            local fop = op:frame()
            local fother = other:frame()
            local screen = op:screen():frame()

            fop.h = fop.h+20
            fother.h = fother.h-20
            fop.y = screen.h - fop.h

            op:setFrame(fop)
            other:setFrame(fother)
        end
    end
end

function resizeLayoutReverse()
    local count = 0
    local appWindows = {}

    local appWindows = getAppWindows()
    local count = #appWindows

    if (balanceFlag) then
        -- hs.alert.show('balance')
        if (count == 2) then
            local other = appWindows[2]
            local op    = appWindows[1]

            local fop = op:frame()
            local fother = other:frame()
            local screen = op:screen():frame()

            fop.w = fop.w-20
            fother.w = fother.w+20
            fop.x = screen.w - fop.w

            op:setFrame(fop)
            other:setFrame(fother)
        end
    end
    if (alterFlag) then
        -- hs.alert.show('alter')
        if (count == 2) then
            local other = appWindows[2]
            local op    = appWindows[1]

            local fop = op:frame()
            local fother = other:frame()
            local screen = op:screen():frame()

            fop.h = fop.h-20
            fother.h = fother.h+20
            fop.y = screen.h - fop.h

            op:setFrame(fop)
            other:setFrame(fother)
        end
    end
end
