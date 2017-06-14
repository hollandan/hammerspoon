-- Modal ViM
local keyCode = function(modifiers, character)
  local event = require("hs.eventtap").event
  event.newKeyEvent(modifiers, string.lower(character), true):post()
  event.newKeyEvent(modifiers, string.lower(character), false):post()
end


modalVimMode = hs.hotkey.modal.new({"cmd", "alt"}, '\\', "Vimificating")

modalVimMode:bind({}, 'h', keyCode('left') ,  nil, keyCode('left')  )
modalVimMode:bind({}, 'j', keyCode('down') ,  nil, keyCode('down')  )
modalVimMode:bind({}, 'k', keyCode('up')   ,  nil, keyCode('up')    )
modalVimMode:bind({}, 'l', keyCode('right'),  nil, keyCode('right') )

function modalVimMode:exited()
  -- hs.screen.primaryScreen():setGamma({alpha=1.0,red=0.0,green=0.0,blue=0.0},{blue=1.0,green=1.0,red=1.0})
  hs.alert.show("No ViM mode")
end

modalVimMode:bind({}, 'escape', function() modalVimMode:exit() end)
