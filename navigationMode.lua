local breakModes = nil
local browserSwitch = nil

-- NOTE: this is also in globalBindings... shouldn't be in two places
local fastKeyStroke = function(modifiers, character)
  local event = require('hs.eventtap').event
  event.newKeyEvent(modifiers, string.lower(character), true):post()
  event.newKeyEvent(modifiers, string.lower(character), false):post()
end

navigationMode = hs.hotkey.modal.new({}, 'F19')
navigationMode:bind({}, 'F19'    , function() end)
navigationMode:bind({}, 'F18'    , function() invokeFunctionMode() end)
navigationMode:bind({}, 'F17'    , function() navigationMode:exit() end)
navigationMode:bind({'shift'}, 'F17'    , function() navigationMode:exit() end)
navigationMode:bind({}, 'escape' , function() navigationMode:exit() end)
-- navigationMode:bind({'ctrl'} , 'space'  , function() navInvokeITerm() end)
-- functions *are* sharing namespace among files
-- so we either need one invokeIterm, or one for each mode...

-- navigationMode:bind({}, 'v', function() visualMode() end)


navigationMode:bind({}, 'a', function() fullLeft() end)
navigationMode:bind({},  41, function() fullRight() end)
navigationMode:bind({}, '`', function() fullUp() end)
navigationMode:bind({}, '/', function() fullDown() end)

navigationMode:bind({'shift'}, 'a', function() fullLeftAndSelect() end)
navigationMode:bind({'shift'},  41, function() fullRightAndSelect() end)
navigationMode:bind({'shift'}, 'q', function() fullUpAndSelect() end)
navigationMode:bind({'shift'}, '/', function() fullDownAndSelect() end)

navigationMode:bind({'shift'}, 'r', function() pageUpAndSelect() end)
navigationMode:bind({'shift'}, 'm', function() pageDownAndSelect() end)
navigationMode:bind({}, 'r', function() pageUp() end)
navigationMode:bind({}, 'm', function() pageDown() end)

-- hs.hotkey.bind(mods, key, message, pressedfn, releasedfn, repeatfn)
-- So interestingly, the only way to get repeatfn to fire is if you display a message.
    -- Setting the message to nil doesn't work .Weird.
-- navigationMode:bind({}, 's', '', function() goLeft() end, nil, function() goLeft() end)
navigationMode:bind({}, 's', nil, function() goLeft() end, nil, function() goLeft() end)
navigationMode:bind({}, 'l', function() goRight() end)
navigationMode:bind({}, 'd', function() goUp() end)
navigationMode:bind({}, 'k', function() goDown() end)

navigationMode:bind({'shift'}, 's', function() goLeftAndSelect() end)
navigationMode:bind({'shift'}, 'l', function() goRightAndSelect() end)
navigationMode:bind({'shift'}, 'd', function() goUpAndSelect() end)
navigationMode:bind({'shift'}, 'k', function() goDownAndSelect() end)

navigationMode:bind({}, 'h', function() deleteBackward() end)
navigationMode:bind({}, 'g', function() deleteForward() end)

navigationMode:bind({}, 'j', function() wordLeft() end)
navigationMode:bind({}, 'f', function() wordRight() end)

navigationMode:bind({'shift'}, 'j', function() wordLeftAndSelect() end)
navigationMode:bind({'shift'}, 'f', function() wordRightAndSelect() end)

navigationMode:bind({}, 'w', function() previousTab() end)
navigationMode:bind({}, 'o', function() nextTab() end)
navigationMode:bind({}, 'q', function() goBack() end)
navigationMode:bind({}, 'p', function() goForward() end)

navigationMode:bind({'cmd'}, 'l', function() focusURLBarAndExit() end)
navigationMode:bind({'cmd'}, 'f', function() findAndExit() end)

navigationMode:bind({}, 'e', function() previousField() end)
navigationMode:bind({}, 'i', function() nextField() end)

navigationMode:bind({}, 't', function() take() end)
navigationMode:bind({}, 'y', function() yank() end)

navigationMode:bind({}, 'c', function()
    hs.eventtap.keyStroke({'cmd'}, 'c')
    hs.eventtap.keyStroke({'cmd'}, 'c')
end)
navigationMode:bind({}, 'v', function()
    hs.eventtap.keyStroke({'cmd'}, 'v')
    hs.eventtap.keyStroke({'cmd'}, 'v')
end)

function invokeFunctionMode()
    navigationMode:exit()
    -- hs.eventtap.keyStroke({}, 'f18')
    fastKeyStroke({}, 'f18')
end

-- function visualMode()
--     visualMode = hs.hotkey.modal.new({}, 'v', 'Visual')
-- end

function navigationMode:entered()

    -- -- Just in case window mode causes the indicator to perpetually stick (by invoking another instance we can delete)
    -- navIndicator:delete()
    -- navIndicator = hs.drawing.rectangle(hs.geometry.rect{0, 0, 1440, 900})
    -- navIndicator:setFill(true);
    -- navIndicator:setFillColor({['red']=0,['blue']=0,['green']=0,['alpha']=0});
    -- navIndicator:setStrokeColor({['red']=1,['blue']=0,['green']=0,['alpha']=.7})
    -- navIndicator:setStrokeWidth(10)
    -- navIndicator:show()

    currentBorder = navigationBorder
    currentIndicator:setStrokeColor(currentBorder);

    -- If we're in iTerm, don't do any navigation remapping
    local currentapp = hs.application.frontmostApplication();
    if (string.match(currentapp:name(), 'iTerm2')) then
        navigationMode:exit()
        functionMode:exit()
    end
end

function navigationMode:exited()
    -- navIndicator:delete()
    currentBorder = focusedBorder
    currentIndicator:setStrokeColor(currentBorder);
end

function fullLeft()
    hs.eventtap.keyStroke({'cmd'}, 'left')
end

function fullRight()
    hs.eventtap.keyStroke({'cmd'}, 'right')
end

function fullUp()

    local currentapp = hs.application.frontmostApplication();
    if (string.match(currentapp:name(), 'Mail')) then
        hs.eventtap.keyStroke({'cmd', 'alt'}, 'up')
    else
        hs.eventtap.keyStroke({'cmd'}, 'up')
    end
end

function fullDown()
    hs.eventtap.keyStroke({'cmd'}, 'down')
end

function fullLeftAndSelect()
    hs.eventtap.keyStroke({'cmd', 'shift'}, 'left')
end

function fullRightAndSelect()
    hs.eventtap.keyStroke({'cmd', 'shift'}, 'right')
end

function fullUpAndSelect()
    hs.eventtap.keyStroke({'cmd', 'shift'}, 'up')
end

function fullDownAndSelect()
    hs.eventtap.keyStroke({'cmd', 'shift'}, 'down')
end

function pageUp()
    local currentapp = hs.application.frontmostApplication();
    if (string.match(currentapp:name(), 'Safari') or
        string.match(currentapp:name(), 'Chrome') or
        string.match(currentapp:name(), 'Firefox'))
    then
        hs.eventtap.keyStroke({'fn'}, 'pageup')
    else
        hs.eventtap.keyStroke({'alt'}, 'pageup')
    end
end

function pageDown()
    local currentapp = hs.application.frontmostApplication();
    if (string.match(currentapp:name(), 'Safari') or
        string.match(currentapp:name(), 'Chrome') or
        string.match(currentapp:name(), 'Firefox'))
    then
        hs.eventtap.keyStroke({'fn'}, 'pagedown')
    else
        hs.eventtap.keyStroke({'alt'}, 'pagedown')
    end
end

function pageUpAndSelect()
    local currentapp = hs.application.frontmostApplication();
    if (string.match(currentapp:name(), 'Safari') or
        string.match(currentapp:name(), 'Chrome') or
        string.match(currentapp:name(), 'Firefox'))
    then
        hs.eventtap.keyStroke({'shift', 'fn'}, 'up')
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'up')
    end
end

function pageDownAndSelect()
    local currentapp = hs.application.frontmostApplication();
    if (string.match(currentapp:name(), 'Safari') or
        string.match(currentapp:name(), 'Chrome') or
        string.match(currentapp:name(), 'Firefox'))
    then
        hs.eventtap.keyStroke({'shift', 'fn'}, 'down')
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'down')
    end
end

function goLeft()
    fastKeyStroke({}, 'left')
end

function goRight()
    fastKeyStroke({}, 'right')
end

function goUp()
    fastKeyStroke({}, 'up')
end

function goDown()
    fastKeyStroke({}, 'down')
end

function goLeftAndSelect()
    fastKeyStroke({'shift'}, 'left')
end

function goRightAndSelect()
    fastKeyStroke({'shift'}, 'right')
end

function goUpAndSelect()
    fastKeyStroke({'shift'}, 'up')
end

function goDownAndSelect()
    fastKeyStroke({'shift'}, 'down')
end

function wordLeft()
    fastKeyStroke({'alt'}, 'left')
end

function wordRight()
    fastKeyStroke({'alt'}, 'right')
end

function wordLeftAndSelect()
    fastKeyStroke({'alt', 'shift'}, 'left')
end

function wordRightAndSelect()
    fastKeyStroke({'alt', 'shift'}, 'right')
end

function deleteBackward()
    fastKeyStroke({}, 'delete')
end

function deleteForward()
    fastKeyStroke({}, 'forwarddelete')
end

function take()
    -- won't work unless done twice... why??
    fastKeyStroke({'ctrl'}, 't')
    fastKeyStroke({'ctrl'}, 't')
end

function yank()
    -- won't work unless done twice... why??
    fastKeyStroke({'ctrl'}, 'y')
    fastKeyStroke({'ctrl'}, 'y')
end



function previousTab()
    local currentapp = hs.application.frontmostApplication();
    if (string.match(currentapp:name(), 'Safari') or string.match(currentapp:name(), 'Chrome') or string.match(currentapp:name(), 'Firefox')) then
        fastKeyStroke({'ctrl', 'shift'}, 'tab')
    else
        -- fastKeyStroke({'ctrl'}, 'w')
        -- ...no idea why, but... fastKeyStroke just doesn't work, and eventtap needs to be called twice to get the functionality...
        hs.eventtap.keyStroke({'ctrl'}, 'w')
        hs.eventtap.keyStroke({'ctrl'}, 'w')
    end
end

function nextTab()
    local currentapp = hs.application.frontmostApplication();
    if (string.match(currentapp:name(), 'Safari') or string.match(currentapp:name(), 'Chrome') or string.match(currentapp:name(), 'Firefox')) then
        fastKeyStroke({'ctrl'}, 'tab')
    else
        -- fastKeyStroke({'ctrl'}, 'o')
        -- ...no idea why, but... fastKeyStroke just doesn't work, and eventtap needs to be called twice to get the functionality...
        hs.eventtap.keyStroke({'ctrl'}, 'o')
        hs.eventtap.keyStroke({'ctrl'}, 'o')
    end
end

function goBack()
    fastKeyStroke({'cmd'}, '[')
end

function goForward()
    fastKeyStroke({'cmd'}, ']')
end

function focusURLBarAndExit()
    fastKeyStroke({'cmd'}, 'l')
    navigationMode:exit()
end

function findAndExit()
    -- seems the only way to get this to work...
    -- otherwise, focus just leaves the find box...
    hs.eventtap.keyStroke({'cmd'}, 'f')
    navigationMode:exit()
    hs.eventtap.keyStroke({'cmd'}, 'f')
    hs.eventtap.keyStroke({'cmd'}, 'f')
end

function previousField()
    local currentapp = hs.application.frontmostApplication();
    if (string.match(currentapp:name(), 'Mail')) then
        fastKeyStroke({}, 'tab')
    else
        fastKeyStroke({'shift'}, 'tab')
    end
end

function nextField()
    fastKeyStroke({}, 'tab')
end

-- Define a callback function to be called when application events happen
function applicationWatcherCallback(appName, eventType, appObject)

    -- hs.alert.show(appName)
    -- hs.alert.show(eventType)
    -- hs.alert.show(appObject)

    if (appName == 'iTerm2') then
        if (eventType == hs.application.watcher.activated) then
            navigationMode:exit()
            functionMode:exit()
            breakModes = true
            currentIndicator:hide()
        else
            breakModes = false
            currentIndicator:show()
        end
    end

    if (appName == 'Safari') then
        if (eventType == hs.application.watcher.activated) then
            browserSwitch = true
        else
            browserSwitch = false
        end
    end
end

-- Create and start the application event watcher
navModeBreaker = hs.application.watcher.new(applicationWatcherCallback)
navModeBreaker:start()

--- ==========
