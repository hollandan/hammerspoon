local fastKeyStroke = function(modifiers, character)
  local event = require("hs.eventtap").event
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
