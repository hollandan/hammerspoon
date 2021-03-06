local topHalf               = hs.geometry.rect(0   , 0   , 1500 , 450)
local bottomHalf            = hs.geometry.rect(0   , 450 , 1500 , 450)
local topLeftQuarter        = hs.geometry.rect(0   , 0   , 750  , 450)
local topRightQuarter       = hs.geometry.rect(750 , 0   , 750  , 450)
local bottomLeftQuarter     = hs.geometry.rect(0   , 450 , 750  , 450)
local bottomRightQuarter    = hs.geometry.rect(750 , 450 , 750  , 450)

local topTwoThirds          = hs.geometry.rect(0   , 0   , 1500 , 600)
local topThird              = hs.geometry.rect(0   , 0   , 1500 , 600)
local bottomThird           = hs.geometry.rect(0   , 600 , 1500 , 300)
local bottomLeftThird       = hs.geometry.rect(0   , 600 , 750  , 300)
local bottomRightThird      = hs.geometry.rect(750 , 600 , 750  , 300)

local leftTwoThirds         = hs.geometry.rect(0   , 0   , 1000 , 900)
local rightTwoThirds        = hs.geometry.rect(450 , 0   , 1000 , 900)
local leftThird             = hs.geometry.rect(0   , 0   , 450  , 900)
local rightThird            = hs.geometry.rect(900 , 0   , 450  , 900)

local leftQuarter           = hs.geometry.rect(0    , 0  , 375 , 900)
local leftMidQuarter        = hs.geometry.rect(375  , 0  , 375 , 900)
local rightMidQuarter       = hs.geometry.rect(750  , 0  , 375 , 900)
local rightQuarter          = hs.geometry.rect(1125 , 0  , 375 , 900)

local centeredThreeQuarters = hs.geometry.rect(150 , 75  , 1150 , 725)

-- local laptopScreen = 'Color LCD'

local balanceFlag = false
local alterFlag = false

-- hs.hotkey.bind({}, 'pad2', function()
--     balanceWindows()
-- end)
-- hs.hotkey.bind({}, 'pad1', function()
--     alterWindows()
-- end)
--
-- hs.hotkey.bind({}, 'pad2', function()
--     balanceWindows()
-- end)
-- hs.hotkey.bind({}, 'pad1', function()
--     alterWindows()
-- end)

hs.hotkey.bind(double_command, '1', function()
    balanceWindows()
end)
hs.hotkey.bind(double_command, '2', function()
    alterWindows()
end)

hs.hotkey.bind(right_command, '3', function()
    showLayoutWindowList()
end)

hs.hotkey.bind({'cmd', 'ctrl'}, 'a', function()
    resizeLayout()
end)

hs.hotkey.bind({'cmd', 'ctrl'}, 's', function()
    resizeLayoutReverse()
end)

function getLayoutWindowList()
    -- local windows = hs.window.allWindows()
    local windows = hs.window.orderedWindows()
    windowlist = {}
    for _,win in pairs(windows) do
        -- hs.alert.show(win:id() .. ': ' .. win:title() .. ' | ' .. win:application():name())
        local app = win:application():name()
        if (app == 'Hammerspoon') then
            -- hs.alert.show('spoon')
        elseif (app == 'iTerm2') then
            -- hs.alert.show('term')
        elseif (win:title() == 'MiniPlayer') then
            -- hs.alert.show('miniplayer')
        else
            if win:isStandard() then
                table.insert(windowlist, win)
            end
        end
    end

    return windowlist
end

function showLayoutWindowList()
    for _,win in pairs(getLayoutWindowList()) do
        hs.alert.show(win:id() .. ': ' .. win:title() .. ' | ' .. win:application():name())
    end
end


function balanceWindows()

    balanceFlag = true
    alterFlag = false

    local laptopScreen = hs.screen.mainScreen()
    local appWindows = getLayoutWindowList()
    local count = #appWindows
    hs.eventtap.keyStroke({'ctrl', 'fn'}, 'f4')

    hs.alert.show(laptopScreen)
 
    -- local appWindows = getAppWindows()
    -- local count = #appWindows
    -- hs.eventtap.keyStroke({'cmd'}, '`')

    if (count == 1) then

        local oneWindow = {
            {thisapp, nil, laptopScreen, hs.layout.maximized, nil, nil}
        }
        hs.layout.apply(oneWindow)

    elseif (count == 2) then

        local twoWindows = {
            {thisapp, appWindows[1], laptopScreen, nil, nil, leftThird},
            {thisapp, appWindows[2], laptopScreen, nil, nil, rightTwoThirds}
        }
        hs.layout.apply(twoWindows)

    elseif (count == 3) then

        local threeWindows = {
            {thisapp, appWindows[1], laptopScreen, nil, nil, bottomRightThird},
            {thisapp, appWindows[2], laptopScreen, nil, nil, bottomLeftThird},
            {thisapp, appWindows[3], laptopScreen, nil, nil, topThird}
        }
        hs.layout.apply(threeWindows)

    elseif (count == 4) then

        local fourWindows = {
            {thisapp, appWindows[1], laptopScreen, nil, nil, topLeftQuarter},
            {thisapp, appWindows[2], laptopScreen, nil, nil, topRightQuarter},
            {thisapp, appWindows[3], laptopScreen, nil, nil, bottomLeftQuarter},
            {thisapp, appWindows[4], laptopScreen, nil, nil, bottomRightQuarter}
        }
        hs.layout.apply(fourWindows)

    elseif (count == 5) then

        local fiveWindows = {
            {thisapp, appWindows[1], laptopScreen, nil, nil, topLeftQuarter},
            {thisapp, appWindows[2], laptopScreen, nil, nil, topRightQuarter},
            {thisapp, appWindows[3], laptopScreen, nil, nil, bottomLeftQuarter},
            {thisapp, appWindows[4], laptopScreen, nil, nil, bottomRightQuarter},
            {thisapp, appWindows[5], laptopScreen, nil, nil, centeredThreeQuarters}
        }
        hs.layout.apply(fiveWindows)

    end

end

function getAppWindows()
    windowList = getLayoutWindowList()

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

    local laptopScreen = hs.screen.mainScreen()
    local appWindows = getLayoutWindowList()
    local count = #appWindows
    hs.eventtap.keyStroke({'ctrl', 'fn'}, 'f4')

    -- local appWindows = getAppWindows()
    -- local count = #appWindows
    -- hs.eventtap.keyStroke({'cmd'}, '`')

    if (count == 1) then

        local oneWindow = {
            {thisapp, nil, laptopScreen, hs.layout.maximized, nil, nil}
        }
        hs.layout.apply(oneWindow)

    elseif (count == 2) then

        local twoWindows = {
            {thisapp, appWindows[1], laptopScreen, nil, nil, topTwoThirds},
            {thisapp, appWindows[2], laptopScreen, nil, nil, bottomThird}
        }
        hs.layout.apply(twoWindows)

    elseif (count == 3) then

        local threeWindows = {
            {thisapp, appWindows[1], laptopScreen, nil, nil, bottomRightThird},
            {thisapp, appWindows[2], laptopScreen, nil, nil, bottomLeftThird},
            {thisapp, appWindows[3], laptopScreen, nil, nil, topThird}
        }
        hs.layout.apply(threeWindows)

    elseif (count == 4) then

        local fourWindows = {
            {thisapp, appWindows[1], laptopScreen, nil, nil, leftQuarter},
            {thisapp, appWindows[2], laptopScreen, nil, nil, leftMidQuarter},
            {thisapp, appWindows[3], laptopScreen, nil, nil, rightMidQuarter},
            {thisapp, appWindows[4], laptopScreen, nil, nil, rightQuarter}
        }
        hs.layout.apply(fourWindows)


    elseif (count == 5) then

        local fiveWindows = {
            {thisapp, appWindows[1], laptopScreen, nil, nil, leftQuarter},
            {thisapp, appWindows[2], laptopScreen, nil, nil, leftMidQuarter},
            {thisapp, appWindows[3], laptopScreen, nil, nil, rightMidQuarter},
            {thisapp, appWindows[4], laptopScreen, nil, nil, rightQuarter},
            {thisapp, appWindows[5], laptopScreen, nil, nil, centeredThreeQuarters}
        }
        hs.layout.apply(fiveWindows)

    end

end



function resizeLayout()
    local count = 0
    local appWindows = {}

    -- local appWindows = getAppWindows()
    local appWindows = getLayoutWindowList()
    local count = #appWindows

    if (balanceFlag) then
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

        -- if (count == 4) then
        --     local quatr = appWindows[4]
        --     local alter = appWindows[3]
        --     local other = appWindows[2]
        --     local op    = appWindows[1]
        --
        --     local fop = op:frame()
        --     local fother = other:frame()
        --     local falter = alter:frame()
        --     local fquatr = quatr:frame()
        --     local screen = op:screen():frame()
        --
        --     fop.w = fop.w+20
        --     fother.w = fother.w-20
        --     fop.x = screen.w - fop.w
        --
        --     op:setFrame(fop)
        --     other:setFrame(fother)
        -- end

    end
    if (alterFlag) then
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

    if (count == 3) then
        local alter = appWindows[3]
        local other = appWindows[2]
        local op    = appWindows[1]

        local fop = op:frame()
        local fother = other:frame()
        local falter = alter:frame()
        local screen = op:screen():frame()

        fop.h = fop.h+20
        fother.h = fother.h-20
        fother.y = fother.y+20
        falter.h = fother.h-20
        falter.y = fother.y+20
        fop.y = 0

        op:setFrame(fop)
        other:setFrame(fother)
        alter:setFrame(falter)
    end
end

function resizeLayoutReverse()
    local count = 0
    local appWindows = {}

    -- local appWindows = getAppWindows()
    local appWindows = getLayoutWindowList()
    local count = #appWindows

    if (balanceFlag) then
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

    if (count == 3) then
        local alter = appWindows[3]
        local other = appWindows[2]
        local op    = appWindows[1]

        local fop = op:frame()
        local fother = other:frame()
        local falter = alter:frame()
        local screen = op:screen():frame()

        fop.h = fop.h-20
        fother.h = fother.h+20
        fother.y = fother.y-20
        falter.h = fother.h+20
        falter.y = fother.y-20
        fop.y = 0

        op:setFrame(fop)
        other:setFrame(fother)
        alter:setFrame(falter)
    end
end



-- V
--     take the window on the left
--         resize it laterally by some small amount
--       <- H   L ->
--     window on the right
--         x: left window width
--         y: right window height
--         h: screen height - left window height
--         w: screen width  - left widow width
--

hs.hotkey.bind(right_command, '5', function()
    testWindows()
end)

function testWindows()

    -- local appWindows = getAppWindows()
    -- local count = #appWindows

    local appWindows = getLayoutWindowList()
    local count = #appWindows
    -- hs.eventtap.keyStroke({'cmd'}, '`')

    hs.alert.show("test windows")
    hs.alert.show(hs.grid.getGridFrame(grid.topHalf))

    balanceFlag = true
    alterFlag = false

    -- local laptopscreen = hs.screen("Color LCD")
    local laptopscreen = hs.screen.allScreens()[1]

    local bigscreen = nil
    if (#hs.screen.allScreens() == 2) then
        -- local bigscreen = hs.screen("HP VH240a")
        bigscreen = hs.screen.allScreens()[2]
        hs.alert.show("bigscreen: " .. bigscreen:name() )
    end
    hs.alert.show("mainscreen: " .. hs.screen.mainScreen():name())
    hs.alert.show("primaryscreen: " .. hs.screen.primaryScreen():name())

    -- hs.alert.show(hs.grid.getCell(grid.topHalf, laptopscreen).y)
    -- hs.alert.show(hs.grid.getCell(grid.topHalf, bigscreen).y)



    if (count == 1) then
        hs.alert.show("1 window")

        local oneWindow = {
            {thisapp, nil, hs.screen.mainScreen(), nil, nil, hs.grid.getGridFrame(grid.bottomHalf)}
        }
        hs.layout.apply(oneWindow)

    elseif (count == 2) then
        hs.alert.show("!")
        hs.alert.show("2 windows: " .. appWindows[1]:title() .. " | " .. appWindows[2]:title())
        hs.alert.show(hs.screen.mainScreen())

        hs.alert.show("---------")
        hs.alert.show(appWindows[1])
        hs.alert.show(appWindows[2])
        hs.alert.show(hs.screen.mainScreen())
        hs.alert.show(hs.screen.mainScreen())
        hs.alert.show("..")
        hs.alert.show("..")
        hs.alert.show("x: " .. hs.grid.getCell(grid.topHalf, hs.screen.mainScreen()).x)
        hs.alert.show("y: " .. hs.grid.getCell(grid.topHalf, hs.screen.mainScreen()).y)
        hs.alert.show("w: " .. hs.grid.getCell(grid.topHalf, hs.screen.mainScreen()).w)
        hs.alert.show("h: " .. hs.grid.getCell(grid.topHalf, hs.screen.mainScreen()).h)

        hs.alert.show("---------")

        local twoWindows = {
            {nil, appWindows[1], hs.screen.mainScreen(), nil, nil, hs.grid.getCell(grid.topHalf, hs.screen.mainScreen())},
            {nil, appWindows[2], hs.screen.mainScreen(), nil, nil, hs.grid.getCell(grid.bottomHalf, hs.screen.mainScreen())},
        }
        hs.layout.apply(twoWindows)
    else
        hs.alert.show("MORE THAN 2")
    end

end
