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

        local amethyst = hs.execute("ps aux | grep Amethyst | wc -l | tr -d ' '")

        if (tonumber(amethyst) < 3) then
            local currentapp = hs.application.frontmostApplication()
            if (string.match(currentapp:name(), 'iTerm2')) then
                hs.eventtap.keyStroke({'ctrl'}, 'tab')
            else
                fastKeyStroke({'cmd'}, '`')
            end
            -- make cursor center in active window; fast, so call it twice to make sure it doesn't fire before the focus is changed
            os.execute('/Applications/Karabiner.app/Contents/Library/utilities/bin/warp-mouse-cursor-position front_window middle 0 center 0')
            os.execute('/Applications/Karabiner.app/Contents/Library/utilities/bin/warp-mouse-cursor-position front_window middle 0 center 0')
        else
            hs.eventtap.keyStroke({'alt', 'shift'}, 'a')
        end

    end)
        -- previous window in app
    hs.hotkey.bind(right_command, 41, function()

        local amethyst = hs.execute("ps aux | grep Amethyst | wc -l | tr -d ' '")

        if (tonumber(amethyst) < 3) then
            local currentapp = hs.application.frontmostApplication()
            if (string.match(currentapp:name(), 'iTerm2')) then
                hs.eventtap.keyStroke({'ctrl', 'shift'}, 'tab')
            else
                fastKeyStroke({'cmd', 'shift'}, '`')
            end
            -- make cursor center in active window; fast, so call it twice to make sure it doesn't fire before the focus is changed
            os.execute('/Applications/Karabiner.app/Contents/Library/utilities/bin/warp-mouse-cursor-position front_window middle 0 center 0')
            os.execute('/Applications/Karabiner.app/Contents/Library/utilities/bin/warp-mouse-cursor-position front_window middle 0 center 0')
        else
            hs.eventtap.keyStroke({'alt', 'shift'}, 's')
        end


    end)
    -- next window in space
    hs.hotkey.bind(right_command, 'j', function()
        local amethyst = hs.execute("ps aux | grep Amethyst | wc -l | tr -d ' '")


        if (tonumber(amethyst) < 3) then
            -- amethyst isn't running
            fastKeyStroke({'ctrl', 'fn'}, 'f4')
            -- make cursor center in active window; fast, so call it twice to make sure it doesn't fire before the focus is changed
            os.execute('/Applications/Karabiner.app/Contents/Library/utilities/bin/warp-mouse-cursor-position front_window middle 0 center 0')
            os.execute('/Applications/Karabiner.app/Contents/Library/utilities/bin/warp-mouse-cursor-position front_window middle 0 center 0')
        else
            -- amethyst is running
            hs.eventtap.keyStroke({'alt', 'shift'}, 'j')
        end
    end)
    -- previous window in space
    hs.hotkey.bind(right_command, 'k', function()
        local amethyst = hs.execute("ps aux | grep Amethyst | wc -l | tr -d ' '")
        if (tonumber(amethyst) < 3) then
            fastKeyStroke({'ctrl', 'shift', 'fn'}, 'f4')
            -- make cursor center in active window; fast, so call it twice to make sure it doesn't fire before the focus is changed
            os.execute('/Applications/Karabiner.app/Contents/Library/utilities/bin/warp-mouse-cursor-position front_window middle 0 center 0')
            os.execute('/Applications/Karabiner.app/Contents/Library/utilities/bin/warp-mouse-cursor-position front_window middle 0 center 0')
        else
            hs.eventtap.keyStroke({'alt', 'shift'}, 'k')
        end
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
