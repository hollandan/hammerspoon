-- keyreference.lua
-- ~/.config/karabiner/karabiner.json
	-- https://pqrs.org/osx/karabiner/json.html

-- karabiner logs located in:
-- /Users/dan/.local/share/karabiner/log

      globals            = require 'globals'
local autoload           = require 'autoload'
local dashboard          = require 'dashboard'
local windowTossing      = require 'windowTossing'
local windowLayout       = require 'windowLayout'
local navigationMode     = require 'navigationMode'
local functionMode       = require 'functionMode'
local karabinerRightCmd  = require 'karabinerRightCmd'
local fuckYouXfinity     = require 'fuckYouXfinity'
local chooser            = require 'chooser'
local mouse              = require 'mouse'
local missionControlMode = require 'missionControlMode'
local editinvim          = require 'editinvim'
local scrap              = require 'scrap'
-- local iterm2             = require 'iterm2'
-- local gaming             = require 'gaming'

require("hs.ipc")
hs.ipc.cliInstall()

-- local interfacer         = require 'interfacer'

hs.hotkey.bind({'shift'}, 'f1', function()
    if hs.brightness.get() > 50 then
        hs.brightness.set(15)
    else
        hs.brightness.set(100)
    end
end)

-- local reloadbrowser      = require 'reloadbrowser'
-- local playground         = require 'playground'


-- How do we toss a window to a specific desktop?

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
