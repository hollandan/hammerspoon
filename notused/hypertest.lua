-- hattip https://github.com/lodestone/hyper-hacks
-- hattip https://gist.github.com/ttscoff/cce98a711b5476166792d5e6f1ac5907

-- A global variable for the sub-key Hyper Mode
k = hs.hotkey.modal.new({}, 'F19')

-- Hyper+key for all the below are setup somewhere
-- The handler already exists, usually in Keyboard Maestro
-- we just have to get the right keystroke sent
hyperBindings = {'c','m','a','r','d','g','s','f','TAB','v','b'}

for i,key in ipairs(hyperBindings) do
  k:bind({}, key, nil, function() hs.eventtap.keyStroke({'cmd','alt','shift','ctrl'}, key)
    k.triggered = true
  end)
end

-- Enter Hyper Mode when F19 (left control) is pressed
pressedF19 = function()
  k.triggered = false
  k:enter()
end

-- Leave Hyper Mode when F19 (left control) is pressed,
--   send ESCAPE if no other keys are pressed.
releasedF19 = function()
  k:exit()
  if not k.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

-- Bind the Hyper key
f19 = hs.hotkey.bind({}, 'F19', pressedF19, releasedF19)

-- vi cursor movement commands
movements = {
 { 'h', {}, 'LEFT'},
 { 'j', {}, 'DOWN'},
 { 'k', {}, 'UP'},
 { 'l', {}, 'RIGHT'},
 { '0', {'cmd'}, 'LEFT'},  -- beginning of line
 { '4', {'cmd'}, 'RIGHT'}, -- end of line
 { 'b', {'alt'}, 'LEFT'},  -- back word
 { 'w', {'alt'}, 'RIGHT'}, -- forward word
}
for i,bnd in ipairs(movements) do
  hs.hotkey.bind({'ctrl'}, bnd[1], function()
    hs.eventtap.keyStroke(bnd[2],bnd[3])
  end)
end
