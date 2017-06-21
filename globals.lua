-- Indicators
navIndicator      = hs.drawing.rectangle(hs.geometry.rect{0, 0, 0, 0})
functionIndicator = hs.drawing.rectangle(hs.geometry.rect{0, 0, 0, 0})

-- nsgMenu
urltoadmin                = hs.hotkey.bind({}, 'pad*', function() end)
urltostructuredcontent    = hs.hotkey.bind({}, 'pad*', function() end)
urltocontentpages         = hs.hotkey.bind({}, 'pad*', function() end)
urltospecificcontentpage  = hs.hotkey.bind({}, 'pad*', function() end)
urltodomain               = hs.hotkey.bind({}, 'pad*', function() end)
 
hs.grid.setGrid('12x12') -- allows us to place on quarters, thirds and halves
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0
hs.window.animationDuration = 0 -- disable animations
grid = {
  topHalf = '0,0 12x6',
  topThird = '0,0 12x4',
  topTwoThirds = '0,0 12x8',
  rightHalf = '6,0 6x12',
  rightThird = '8,0 4x12',
  rightTwoThirds = '4,0 8x12',
  bottomHalf = '0,6 12x6',
  bottomThird = '0,8 12x4',
  bottomTwoThirds = '0,4 12x8',
  leftHalf = '0,0 6x12',
  leftThird = '0,0 4x12',
  leftTwoThirds = '0,0 8x12',
  topLeft = '0,0 6x6',
  topRight = '6,0 6x6',
  bottomRight = '6,6 6x6',
  bottomLeft = '0,6 6x6',
  fullScreen = '0,0 12x12',
  centeredBig = '3,3 6x6',
  centeredSmall = '4,4 4x4',
}

-- Store window frames (by id) so we can toggle window size
frameCache = {}

fastKeyStroke = function(modifiers, character)
  local event = require("hs.eventtap").event
  event.newKeyEvent(modifiers, string.lower(character), true):post()
  event.newKeyEvent(modifiers, string.lower(character), false):post()
end
