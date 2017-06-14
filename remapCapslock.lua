-- https://gist.github.com/zcmarine/f65182fe26b029900792fa0b59f09d7f
-- Inspired by https://github.com/jasoncodes/dotfiles/blob/master/hammerspoon/control_escape.lua
-- You'll also have to install Karabiner Elements and map caps_lock to left_control there
local len = function(t)
    local length = 0
    for k, v in pairs(t) do
    	length = length + 1
    end
    return length
end


caps_send_escape = false
caps_prev_modifiers = {}

caps_modifier_handler = function(evt)
    -- evt:getFlags() holds the modifiers that are currently held down
    local caps_curr_modifiers = evt:getFlags()

    if caps_curr_modifiers["ctrl"] and len(caps_curr_modifiers) == 1 and len(caps_prev_modifiers) == 0 then
        -- We need this here because we might have had additional modifiers, which
        -- we don't want to lead to an escape, e.g. [Ctrl + Cmd] —> [Ctrl] —> [ ]
        caps_send_escape = true
    elseif caps_prev_modifiers["ctrl"]  and len(caps_curr_modifiers) == 0 and caps_send_escape then
		caps_send_escape = false
        -- hs.eventtap.keyStroke({}, "ESCAPE")
        hs.eventtap.keyStroke({}, "f19")
    else
        caps_send_escape = false
	end
    caps_prev_modifiers = caps_curr_modifiers
	return false
end


-- Call the modifier_handler function anytime a modifier key is pressed or released
caps_modifier_tap = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, caps_modifier_handler)
caps_modifier_tap:start()


-- If any non-modifier key is pressed, we know we won't be sending an escape
caps_non_modifier_tap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(evt)
    caps_send_escape = false
	return false
end)
caps_non_modifier_tap:start()
