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
local fuckYouXfinity    = require 'fuckYouXfinity'
local chooser           = require 'chooser'

-- Use chooser to:
    -- select a specific app by typing
    -- get list of windows and choose by typing
-- See windowTossing.lua -> markWindow
    -- so, we can mark one window
    -- now, the question is, how do we associate that border with each window id?
    -- so, we can have multiple borders that can be deleted when unmarked?
    -- then the fun stuff begins
        --  how can we do cool shit to the windows we've marked?

-- HERE'S A THOUGHT!
    -- Maybe navigation mode should draw a border around the CURRENT WINDOW
        -- not the entire screen
    -- that might be easier to see, and perhaps more intuitive


-- Don't forget about this?
-- local vimouse = require('notused/vimouse')
-- vimouse('cmd', 'm')
