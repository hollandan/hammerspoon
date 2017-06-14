local fastKeyStroke = function(modifiers, character)
  local event = require("hs.eventtap").event
  event.newKeyEvent(modifiers, string.lower(character), true):post()
  event.newKeyEvent(modifiers, string.lower(character), false):post()
end

hs.hotkey.bind({'ctrl'}, 'g', function()
    fastKeyStroke({}, 'forwarddelete')
end)
