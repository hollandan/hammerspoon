-- hs.inspect(hs.keycodes.map)

globals = require 'globals'

local autoload          = require 'autoload'
local globalBindings    = require 'globalBindings'
local windowTossing     = require 'windowTossing'
local windowLayout      = require 'windowLayout'
local navigationMode    = require 'navigationMode'
local functionMode      = require 'functionMode'
local karabinerRightCmd = require 'karabinerRightCmd'
local hyperRightShift   = require 'hyperRightShift'

-- gonna need:
--  windowMode

-- hs.hotkey.bind({'cmd', 'ctrl'}, "b", function()
--     hs.alert.show("happened")
--     os.execute("/Users/dan/pyscript/dotSpaceDash.py")
-- end)

-- local vimouse = require('vimouse')
--    vimouse('rightcmd', 'm')
