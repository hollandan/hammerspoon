-- ~/.config/karabiner/karabiner.json
-- Karabiner Elements Mappings
-- right_command
    -- control+option+shift when held
    -- f17 when tapped to exit navigationMode
-- caps_lock
    -- control when used as modifier
    -- f19 when tapped to enter navigationMode
-- return
    -- control when used as modifier
    -- return when used alone

return_modifier = {'alt', 'ctrl'}
right_command   = {'alt', 'ctrl', 'shift'}
double_command  = {'cmd', 'alt', 'ctrl', 'shift'}

hs.hotkey.bind(double_command, 'h', function()
    hs.reload()
end)

-- Indicators (deprecated?)
-- navIndicator      = hs.drawing.rectangle(hs.geometry.rect{0, 0, 0, 0})
-- functionIndicator = hs.drawing.rectangle(hs.geometry.rect{0, 0, 0, 0})

-- nsgMenu
-- Define these to placeholder values here, so Hammerspoon doesn't throw undefined errors
urltoadmin                     = hs.hotkey.bind({}, 'pad*', function() end)
urltostructuredcontent         = hs.hotkey.bind({}, 'pad*', function() end)
urltocontentpages              = hs.hotkey.bind({}, 'pad*', function() end)
urltospecificcontentpage       = hs.hotkey.bind({}, 'pad*', function() end)
urltospecificstructuredcontent = hs.hotkey.bind({}, 'pad*', function() end)
urltodomain                    = hs.hotkey.bind({}, 'pad*', function() end)
urltouri                       = hs.hotkey.bind({}, 'pad*', function() end)

hs.grid.setGrid('12x12')
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0
hs.window.animationDuration = 0
grid = {
  topHalf                = '0,0 12x6',
  topThird               = '0,0 12x4',
  topTwoThirds           = '0,0 12x8',
  rightHalf              = '6,0 6x12',
  rightThird             = '8,0 4x12',
  rightTwoThirds         = '4,0 8x12',
  bottomHalf             = '0,6 12x6',
  bottomThird            = '0,8 12x4',
  bottomTwoThirds        = '0,4 12x8',
  leftHalf               = '0,0 6x12',
  leftThird              = '0,0 4x12',
  leftTwoThirds          = '0,0 8x12',
  topLeft                = '0,0 6x6',
  topRight               = '6,0 6x6',
  bottomRight            = '6,6 6x6',
  bottomLeft             = '0,6 6x6',
  fullScreen             = '0,0 12x12',
  centeredBig            = '3,3 6x6',
  centeredSmall          = '4,4 4x4',
  topLeftSplitTop        = '0,0 6x3',
  topLeftSplitBottom     = '0,3 6x3',
  bottomLeftSplitTop     = '0,6 6x3',
  bottomLeftSplitBottom  = '0,9 6x3',
  topRightSplitTop       = '6,0 6x3',
  topRightSplitBottom    = '6,3 6x3',
  bottomRightSplitTop    = '6,6 6x3',
  bottomRightSplitBottom = '6,9 6x3',
}

-- Store window frames (by id) so we can toggle window size
fullFrameCache = {}
centeredFrameCache = {}
markedFrameCache = {}

-- use this as a placeholder to retain clipboard contents when performing copy/pastes in scripts
pasteboard = ""

showBorders      = true
-- for color ideas: http://www.rapidtables.com/web/color/RGB_Color.htm
-- focusedBorder    = {["red"]=1,["blue"]=0,["green"]=1,["alpha"]=0.9}
focusedBorder    = {["red"]=0,["blue"]=.6,["green"]=.1,["alpha"]=0.5}
navigationBorder = {["red"]=1,["blue"]=0,["green"]=0,["alpha"]=0.9}
functionBorder   = {['red']=0,['blue']=1,['green']=0,['alpha']=0.9}
emptyBorder      = {['red']=0,['blue']=0,['green']=0,['alpha']=0.0}

currentBorder    = focusedBorder
-- currentBorder    = emptyBorder

currentIndicator = hs.drawing.rectangle(hs.geometry.rect{0, 0, 0, 0})
-- https://github.com/jwkvam/hammerspoon-config/blob/master/init.lua#L233

-- b doesn't work...
-- so, l for "lines"
hs.hotkey.bind(double_command, 'l', function()
    if showBorders then
        showBorders = false
        currentIndicator:hide()
    else
        showBorders = true
        redrawBorder()
        currentIndicator:show()
    end
end)

------------------------------------------------
-- -- This is freaking cool, but it draws so slowly it's too distracting to work with
-- hs.window.highlight.ui.overlay = true
-- -- hs.window.highlight.ui.overlayColor = {0.2,0.05,0,0.25}
-- hs.window.highlight.ui.overlayColor = {0,0,0,0.2}
-- hs.window.highlight.ui.overlayColorInverted = {0.8,0.9,1,0.3}
-- hs.window.highlight.ui.isolateColor = {0,0,0,0.95}
-- hs.window.highlight.ui.isolateColorInverted = {1,1,1,0.95}
-- hs.window.highlight.ui.frameWidth = 10
-- hs.window.highlight.ui.frameColor = {0,0.6,1,0.5}
-- hs.window.highlight.ui.frameColorInvert = {1,0.4,0,0.5}
-- hs.window.highlight.ui.flashDuration = 0
-- hs.window.highlight.ui.windowShownFlashColor = {0,1,0,0.8}
-- hs.window.highlight.ui.windowHiddenFlashColor = {1,0,0,0.8}
-- hs.window.highlight.ui.windowShownFlashColorInvert = {1,0,1,0.8}
-- hs.window.highlight.ui.windowHiddenFlashColorInvert = {0,1,1,0.8}
--
-- -- function highlightStuff()
--     hs.window.highlight.start()
-- -- end
-- hs.hotkey.bind('ctrl-cmd','\\', nil,hs.window.highlight.toggleIsolate)
------------------------------------------------

function redrawBorder()
    if showBorders then
        win = hs.window.focusedWindow()

        if win ~= nil then
            top_left = win:topLeft()
            size = win:size()

            -- -- Why do ghost borders persist in the Finder?
            -- -- Interest is probably on cmd-w
            -- -- when we close the window, that's when the ghost persists
            -- hs.alert.show(win:title())
            -- hs.alert.show(win:application():name())
            --
            -- if string.match(win:application():name() ,"Finder") or
            --     win:title() == nil then
            --     currentIndicator:setStrokeColor(emptyBorder)
            -- end


            if currentIndicator ~= nil then
                currentIndicator:delete()
            end
            currentIndicator = hs.drawing.rectangle(hs.geometry.rect(top_left['x'], top_left['y'], size['w'], size['h']))
            currentIndicator:setStrokeColor(currentBorder)
            currentIndicator:setFill(false)
            currentIndicator:setStrokeWidth(8)
            currentIndicator:setRoundedRectRadii(5.0, 5.0)

            if string.match(win:application():name() , 'iTerm'    ) or
               string.match(win:title()              , 'Spotlight') or
               string.match(win:title()              , 'Chooser'  ) then
                currentIndicator:setStrokeColor(emptyBorder)
            end
            currentIndicator:show()
        else
            currentIndicator:hide()
        end
    end
end

redrawBorder()

allwindows = hs.window.filter.new(nil)
allwindows:subscribe(hs.window.filter.windowCreated, function () redrawBorder() end)
allwindows:subscribe(hs.window.filter.windowFocused, function () redrawBorder() end)
allwindows:subscribe(hs.window.filter.windowMoved, function () redrawBorder() end)
allwindows:subscribe(hs.window.filter.windowUnfocused, function () redrawBorder() end)

local fastKeyStroke = function(modifiers, character)
  local event = require('hs.eventtap').event
  event.newKeyEvent(modifiers, string.lower(character), true):post()
  event.newKeyEvent(modifiers, string.lower(character), false):post()
end

hs.hotkey.bind({'ctrl'}, 'g', function()
    fastKeyStroke({}, 'forwarddelete')
end)

-- clever way to prevent system beeps from tapping right_command when not in navigationMode
hs.hotkey.bind({}, 'f17', function()
    fastKeyStroke({}, 'eisu')
end)
