-- Leave custom mode
    hs.hotkey.bind(right_command, 'space', function()
        invokeSpotlight()
    end)

    hs.hotkey.bind(right_command, 'return', function()
        fastKeyStroke({'cmd'}, 'return')
    end)


-- Windows
    -- next window in app
    hs.hotkey.bind(right_command, 'l', function()
        local currentapp = hs.application.frontmostApplication()
        if (string.match(currentapp:name(), 'iTerm2')) then
            hs.eventtap.keyStroke({'ctrl'}, 'tab')
        else
            fastKeyStroke({'cmd'}, '`')
        end
    end)
        -- previous window in app
    hs.hotkey.bind(right_command, 41, function()
        local currentapp = hs.application.frontmostApplication()
        if (string.match(currentapp:name(), 'iTerm2')) then
            hs.eventtap.keyStroke({'ctrl', 'shift'}, 'tab')
        else
            fastKeyStroke({'cmd', 'shift'}, '`')
        end
    end)
        -- next window in space
    hs.hotkey.bind(right_command, 'j', function()
        fastKeyStroke({'ctrl', 'fn'}, 'f4')
    end)
        -- previous window in space
    hs.hotkey.bind(right_command, 'k', function()
        fastKeyStroke({'ctrl', 'shift', 'fn'}, 'f4')
    end)

-- Convenient Zoom
    hs.hotkey.bind(right_command, 'i', function()
       hs.eventtap.keyStroke({'cmd'}, '=')
       hs.eventtap.keyStroke({'cmd'}, '=')
       hs.eventtap.keyStroke({'cmd'}, '=')
       hs.eventtap.keyStroke({'cmd'}, '=')
    end)
    hs.hotkey.bind(right_command, 'e', function()
       hs.eventtap.keyStroke({'cmd'}, '-')
       hs.eventtap.keyStroke({'cmd'}, '-')
       hs.eventtap.keyStroke({'cmd'}, '-')
       hs.eventtap.keyStroke({'cmd'}, '-')
    end)


function invokeSpotlight()
    fastKeyStroke({'cmd'}, 'space')
    navigationMode:exit()
    redrawBorder()
end

-- invoke dock
hs.hotkey.bind(right_command, 'tab', function()
    hs.eventtap.keyStroke({'ctrl, fn'}, 'f3')
end)

function findShit()
    fastKeyStroke({'cmd'}, 'f')
    navigationMode:exit()
end

-- Misc
function makeBagels()
    -- hs.alert.show("Yummy bagels yo")
    local ex = hs.expose.new()
    ex:show()
end

-- Invoke context menu (from center window position)
hs.hotkey.bind(right_command, '`', function()
    local currentapp = hs.application.frontmostApplication();

    os.execute('/Applications/Karabiner.app/Contents/Library/utilities/bin/warp-mouse-cursor-position front_window middle 0 center 0')
    hs.eventtap.rightClick(hs.mouse.getAbsolutePosition())

    if (string.match(currentapp:name(), 'iTerm')) then
        hs.eventtap.keyStroke({}, 'm');
    end
end)

-- hs.hotkey.bind(right_command, 'return', function()
--     local currentapp = hs.application.frontmostApplication();
--
--     if (string.match(currentapp:name(), 'Safari')) then
--         hs.eventtap.keyStroke({'cmd'}, 'return');
--     end
-- end)
