-- keyreference.lua
-- ~/.config/karabiner/karabiner.json
	-- https://pqrs.org/osx/karabiner/json.html

local autoload           = require 'autoload'
globals                  = require 'globals'
local windowTossing      = require 'windowTossing'
local windowLayout       = require 'windowLayout'
local navigationMode     = require 'navigationMode'
local functionMode       = require 'functionMode'
local karabinerRightCmd  = require 'karabinerRightCmd'
local hyperRightShift    = require 'hyperRightShift'
local fuckYouXfinity     = require 'fuckYouXfinity'
local chooser            = require 'chooser'
local mouse              = require 'mouse'
local missionControlMode = require 'missionControlMode'

-- Window Cache still doesn't work how we want it to...
    -- Cache should be updated on SnapBack, too

-- Mouse keys needs some work!!

-- How about some smart exiting of navigation mode
    -- If I start typing a bunch of digits, then a - or /
        --  exit navigation
    --  If I start typing chars that aren't associated with any navigation function
        --  exit navigation?

-- How do we toss a window to a specific desktop?

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
