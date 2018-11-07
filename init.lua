-- ***** Please Note!  ************************************************************
-- ** These are my personal settings
-- ** They are not not well documented
-- ** They rely on configs from:
--    * ~/.hammerspoon/
--    * ~/.config/karabiner/karabiner.json
--    * ~/Library/KeyBindings/DefaultKeyBinding.dict
--    * Better Touch Tool
--    * And, probably a lot of other things, too
-- ** DO NOT expect a direct copy and paste will work on your system
-- ** DO expect a direct copy and paste will break your system
-- ** Also: It is possible some code was stolen from other sources and not credited
--    * If that's the case, sorry. Tell me; I'll do my best to credit appropriately
-- ********************************************************************************
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
local gaming             = require 'gaming'

-- local interfacer         = require 'interfacer'
-- local webivew            = require 'webview'

hs.hotkey.bind({'shift'}, 'f1', function()
    hs.brightness.set(15)
end)

hs.hotkey.bind({'shift'}, 'f2', function()
    hs.brightness.set(100)
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
