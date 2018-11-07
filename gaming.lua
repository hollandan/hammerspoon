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
