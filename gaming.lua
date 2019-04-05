local key_one
local key_two

function applicationWatcherCallback(appName, eventType, appObject)
    if (appName == 'Risk of Rain') then
        if (eventType == hs.application.watcher.activated) then
            key_one = hs.hotkey.bind({}, '1', function() ROR_zoomTo3X() end)
            key_two = hs.hotkey.bind({}, '2', function() ROR_zoomTo1X() end)
        else
            key_one:delete()
            key_two:delete()
        end
    end
end

gameTime = hs.application.watcher.new(applicationWatcherCallback)
gameTime:start()

-- ROR ------------------------------------------------------------------------
function ROR_zoomTo3X()
    hs.eventtap.keyStroke({}, 'escape')
    hs.eventtap.leftClick(hs.geometry.rect({750, 430}), 500000)
    hs.eventtap.leftClick(hs.geometry.rect({750, 415}), 500000)
    hs.eventtap.leftClick(hs.geometry.rect({750, 385}), 500000)
    hs.eventtap.leftClick(hs.geometry.rect({750, 385}), 500000)
    -- ...? why the fuck do we have to do the last one twice?
    hs.eventtap.keyStroke({}, 'escape')
end

function ROR_zoomTo1X()
    hs.eventtap.keyStroke({}, 'escape')
    hs.eventtap.leftClick(hs.geometry.rect({750, 390}), 500000)
    hs.eventtap.leftClick(hs.geometry.rect({750, 340}), 500000)
    hs.eventtap.leftClick(hs.geometry.rect({750, 310}), 500000)
    hs.eventtap.leftClick(hs.geometry.rect({750, 280}), 500000)
    hs.eventtap.leftClick(hs.geometry.rect({750, 280}), 500000)
    hs.eventtap.leftClick(hs.geometry.rect({750, 280}), 500000)
    -- ...? why the fuck do we have to do the last one three times?!??
    hs.eventtap.keyStroke({}, 'escape')
end

-- UnEpic ------------------------------------------------------------------------

-- CoQ ---------------------------------------------------------------------------
-- function coq()
--
--     -- Northwest
--     hs.hotkey.bind({}, 'w', function() hs.eventtap.keyStroke({}, 'pad7') end)
--     -- North
--     hs.hotkey.bind({}, 'd', function() hs.eventtap.keyStroke({}, 'pad8') end)
--     -- Northeast
--     hs.hotkey.bind({}, 'o', function() hs.eventtap.keyStroke({}, 'pad9') end)
--     -- West
--     hs.hotkey.bind({}, 'l', function() hs.eventtap.keyStroke({}, 'pad4') end)
--     -- East
--     hs.hotkey.bind({}, 's', function() hs.eventtap.keyStroke({}, 'pad6') end)
--     -- Southwest
--     hs.hotkey.bind({}, 'n', function() hs.eventtap.keyStroke({}, 'pad1') end)
--     -- South
--     hs.hotkey.bind({}, 'k', function() hs.eventtap.keyStroke({}, 'pad2') end)
--     -- Southeast
--     hs.hotkey.bind({}, 'v', function() hs.eventtap.keyStroke({}, 'pad3') end)
--     -- Up
--     hs.hotkey.bind({}, 'r', function() hs.eventtap.keyStroke({}, 'pad-') end)
--     -- Down
--     hs.hotkey.bind({}, 'm', function() hs.eventtap.keyStroke({}, 'pad+') end)
--
--     -- Force Attack Northwest
--     hs.hotkey.bind({'ctrl'}, 'w', function() hs.eventtap.keyStroke({'ctrl'}, 'pad7') end)
--     -- Force Attack North
--     hs.hotkey.bind({'ctrl'}, 'd', function() hs.eventtap.keyStroke({'ctrl'}, 'pad8') end)
--     -- Force Attack Northeast
--     hs.hotkey.bind({'ctrl'}, 'o', function() hs.eventtap.keyStroke({'ctrl'}, 'pad9') end)
--     -- Force Attack West
--     hs.hotkey.bind({'ctrl'}, 'l', function() hs.eventtap.keyStroke({'ctrl'}, 'pad4') end)
--     -- Force Attack East
--     hs.hotkey.bind({'ctrl'}, 's', function() hs.eventtap.keyStroke({'ctrl'}, 'pad6') end)
--     -- Force Attack Southwest
--     hs.hotkey.bind({'ctrl'}, 'n', function() hs.eventtap.keyStroke({'ctrl'}, 'pad1') end)
--     -- Force Attack South
--     hs.hotkey.bind({'ctrl'}, 'k', function() hs.eventtap.keyStroke({'ctrl'}, 'pad2') end)
--     -- Force Attack Southeast
--     hs.hotkey.bind({'ctrl'}, 'v', function() hs.eventtap.keyStroke({'ctrl'}, 'pad3') end)
--     -- Force Attack Up
--     hs.hotkey.bind({'ctrl'}, 'r', function() hs.eventtap.keyStroke({'ctrl'}, 'pad-') end)
--     -- Force Attack Down
--     hs.hotkey.bind({'ctrl'}, 'm', function() hs.eventtap.keyStroke({'ctrl'}, 'pad+') end)
--
--
--     -- Zoom In
--     -- Zoom Out
--     -- Toggle Sidebar
--     -- Cycle Sidebar Mode
--     -- Toggle Terse Messages
--
--     hs.hotkey.bind({}, '.', function() hs.eventtap.keyStroke({}, 'pad5') end)
--
-- end
