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


rightShift_send_escape = false
rightShift_prev_modifiers = {}

rightShift_modifier_handler = function(evt)
    -- evt:getFlags() holds the modifiers that are currently held down
    local rightShift_curr_modifiers = evt:getFlags()

    if rightShift_curr_modifiers["rightshift"] and len(rightShift_curr_modifiers) == 1 and len(rightShift_prev_modifiers) == 0 then
        -- We need this here because we might have had additional modifiers, which
        -- we don't want to lead to an escape, e.g. [Ctrl + Cmd] —> [Ctrl] —> [ ]
        rightShift_send_escape = true
    elseif rightShift_prev_modifiers["rightshift"]  and len(rightShift_curr_modifiers) == 0 and rightShift_send_escape then
		rightShift_send_escape = false
        hs.eventtap.keyStroke({}, "ESCAPE")
    else
        rightShift_send_escape = false
	end
    rightShift_prev_modifiers = rightShift_curr_modifiers
	return false
end


-- Call the modifier_handler function anytime a modifier key is pressed or released
rightShift_modifier_tap = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, rightShift_modifier_handler)
rightShift_modifier_tap:start()


-- If any non-modifier key is pressed, we know we won't be sending an escape
rightShift_non_modifier_tap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(evt)
    rightShift_send_escape = false
	return false
end)
rightShift_non_modifier_tap:start()
