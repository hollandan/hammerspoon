-- hs.inspect(hs.keycodes.map)

globals = require 'globals'

local autoload        = require 'autoload'
local globalBindings  = require 'globalBindings'
local windowTossing   = require 'windowTossing'
local windowLayout    = require 'windowLayout'
local remapCapslock   = require 'remapCapslock'
local navigationMode  = require 'navigationMode'
local functionMode    = require 'functionMode'
local hyperRightCmd   = require 'hyperRightCmd'
local hyperRightShift = require 'hyperRightShift'


-- gonna need:
--  windowMode

-- local remapRightCmd  = require 'remapRightCmd'



-- local vim  = require 'vim'
-- local fast = require 'fast'
-- local eventtap = require 'greg-eventtap'

-- local hypertest = require 'hypertest'


-- hs.hotkey.bind({'cmd', 'ctrl'}, "b", function()
--     hs.alert.show("happened")
--     os.execute("/Users/dan/pyscript/dotSpaceDash.py")
-- end)

-- local vimouse = require('vimouse')
--    vimouse('rightcmd', 'm')


-- function dump(o)
--    if type(o) == 'table' then
--       local s = '{ '
--       for k,v in pairs(o) do
--          if type(k) ~= 'number' then k = '"'..k..'"' end
--          s = s .. '['..k..'] = ' .. dump(v) .. ','
--       end
--       return s .. '} '
--    else
--       return tostring(o)
--    end
-- end
-- hs.alert.show(dump(var))
