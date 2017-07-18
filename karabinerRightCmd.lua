-- local right_command = {'cmd', 'alt', 'ctrl', 'shift'}

local fastKeyStroke = function(modifiers, character)
  local event = require("hs.eventtap").event
  event.newKeyEvent(modifiers, string.lower(character), true):post()
  event.newKeyEvent(modifiers, string.lower(character), false):post()
end


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
        fastKeyStroke({'cmd'}, '`')
    end)
        -- previous window in app
    hs.hotkey.bind(right_command, 41, function()
        fastKeyStroke({'cmd', 'shift'}, '`')
    end)
        -- next window in space
    hs.hotkey.bind(right_command, 'j', function()
        fastKeyStroke({'ctrl', 'fn'}, 'f4')
    end)
        -- previous window in space
    hs.hotkey.bind(right_command, 'k', function()
        fastKeyStroke({'ctrl', 'shift', 'fn'}, 'f4')
    end)


function invokeSpotlight()
    fastKeyStroke({'cmd'}, 'space')
    navigationMode:exit()
    redrawBorder()
end

function findShit()
    fastKeyStroke({'cmd'}, 'f')
    navigationMode:exit()
end


-- Use Karabiner the Elder to throw the cursor to the center of the currently focused window
hs.hotkey.bind(right_command, 'tab', function()
    os.execute('/Applications/Karabiner.app/Contents/Library/utilities/bin/warp-mouse-cursor-position front_window middle 0 center 0')
end)

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
        hs.eventtap.keyStroke({}, 's');
        hs.eventtap.keyStroke({}, 'return');
    end
end)
