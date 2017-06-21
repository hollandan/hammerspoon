-- -- https://gist.github.com/zcmarine/f65182fe26b029900792fa0b59f09d7f
-- -- Inspired by https://github.com/jasoncodes/dotfiles/blob/master/hammerspoon/control_escape.lua
-- -- You'll also have to install Karabiner Elements and map caps_lock to left_control there
-- local len = function(t)
--     local length = 0
--     for k, v in pairs(t) do
--     	length = length + 1
--     end
--     return length
-- end
--
--
-- rightcmd_send_escape = false
-- rightcmd_prev_modifiers = {}
--
-- rightcmd_modifier_handler = function(evt)
--     -- evt:getFlags() holds the modifiers that are currently held down
--     local rightcmd_curr_modifiers = evt:getFlags()
--
--     if rightcmd_curr_modifiers["cmd"] and len(rightcmd_curr_modifiers) == 1 and len(rightcmd_prev_modifiers) == 0 then
--         rightcmd_send_escape = true
--     elseif rightcmd_prev_modifiers["cmd"]  and len(rightcmd_curr_modifiers) == 0 and rightcmd_send_escape then
-- 		rightcmd_send_escape = false
--         hs.eventtap.keyStroke({}, "f17")
--     else
--         rightcmd_send_escape = false
-- 	end
--     rightcmd_prev_modifiers = rightcmd_curr_modifiers
-- 	return false
-- end
--
--
-- -- Call the modifier_handler function anytime a modifier key is pressed or released
-- rightcmd_modifier_tap = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, rightcmd_modifier_handler)
-- rightcmd_modifier_tap:start()
--
--
-- -- If any non-modifier key is pressed, we know we won't be sending an escape
-- rightcmd_non_modifier_tap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(evt)
--     rightcmd_send_escape = false
-- 	return false
-- end)
-- rightcmd_non_modifier_tap:start()



-------

-- Credit for this implementation goes to @arbelt and @jasoncodes 🙇⚡️😻
--
--   https://gist.github.com/arbelt/b91e1f38a0880afb316dd5b5732759f1
--   https://github.com/jasoncodes/dotfiles/blob/ac9f3ac/hammerspoon/control_escape.lua

send_f17 = false
rightCmd_last_mods = {}

rightCmd_key_handler = function()
  send_f17 = false
end

rightCmd_key_timer = hs.timer.delayed.new(0.15, rightCmd_key_handler)

rightCmd_handler = function(evt)
  local rightCmd_new_mods = evt:getFlags()
  if rightCmd_last_mods["f17"] == rightCmd_new_mods["f17"] then
    return false
  end
  if not rightCmd_last_mods["f17"] then
    rightCmd_last_mods = rightCmd_new_mods
    send_f17 = true
    rightCmd_key_timer:start()
  else
    if send_f17 then
      keyUpDown({}, 'rightcmd')
    end
    rightCmd_last_mods = rightCmd_new_mods
    rightCmd_key_timer:stop()
  end
  return false
end

rightCMD_tap = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, rightCmd_handler)
rightCMD_tap:start()

rightCmd_other_handler = function(evt)
  send_f17 = false
  return false
end

rightCmd_other_tap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, rightCmd_other_handler)
rightCmd_other_tap:start()
