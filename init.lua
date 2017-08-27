-- hs.inspect(hs.keycodes.map)

local autoload          = require 'autoload'
globals                 = require 'globals'
local windowTossing     = require 'windowTossing'
local windowLayout      = require 'windowLayout'
local navigationMode    = require 'navigationMode'
local functionMode      = require 'functionMode'
local karabinerRightCmd = require 'karabinerRightCmd'
local hyperRightShift   = require 'hyperRightShift'
local fuckYouXfinity    = require 'fuckYouXfinity'
local chooser           = require 'chooser'
local mouse             = require 'mouse'

-- What if we make WindowTossing work like this:
-- -- Chain is used to toggle size
-- -- Keyboard locations are used to send to the corresponding place on the screen..

-- see https://github.com/dsanson/hs.tiling

--  fix borders on
    -- spotlight --> escape (we'll probably need a spotlight mode to deal with this)

--  can our window borders have a "z-index" ?
    --  i'd like the following to draw OVER the borders:
        -- hammerspoon alerts
        -- spotlight window
        -- chooser window
        -- quicklook widow
        -- dock
        -- else?

-- chooser
    --  on executions: first check to see if a window containing the result exists
        --  if yes, set as foremost
        --  else, launch
    --  why doesn't navigationMode work on the chooser?

-- See windowTossing.lua -> markWindow
    -- so, we can mark one window
    -- now, the question is, how do we associate that border with each window id?
    -- so, we can have multiple borders that can be deleted when unmarked?
    -- then the fun stuff begins
        --  how can we do cool shit to the windows we've marked?

-- Implemented and ready for testing!
    -- navigation mode draws a border around the CURRENT WINDOW
        -- Red Border: Navigation mode
        -- Blue Border: Function mode
        -- Light Blue Border: Window's selected, that's all
    -- We can do the following (enable redrawBorder() in windowTossing.lua)
        -- 1) Hide the border when iTerm's Hotkey Window is active
        -- 2) Change the color of the border based on mode
        -- 3) notice  when the current Window changes?

-- Don't forget about this?
-- local vimouse = require('notused/vimouse')
-- vimouse('cmd', 'm')
