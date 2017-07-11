-- Reference: https://aldur.github.io/articles/hammerspoon-emojis/
-- Focus the last used window.
local function focusLastFocused()
    local wf = hs.window.filter
    local lastFocused = wf.defaultCurrentSpace:getWindows(wf.sortByFocusedLast)
    if #lastFocused > 0 then lastFocused[1]:focus() end
end

-----------------
-- App Chooser
-----------------
    -- actions:
        --  l => Launch
        --  e => Execute
local apps = {
    { ["text"]    = "C",
      ["subText"] = "Google Chrome",
      ["action"]  = "l"
    },
    { ["text"]    = "D",
      ["subText"] = "Cyberduck",
      ["action"]  = "l"
    },
    { ["text"]    = "E",
      ["subText"] = "Karabiner-EventViewer",
      ["action"]  = "l"
    },
    { ["text"]    = "I",
      ["subText"] = "iTunes",
      ["action"]  = "l"
    },
    { ["text"]    = "F",
      ["subText"] = "FirefoxDeveloperEdition",
      ["action"]  = "l"
    },
    { ["text"]    = "H",
      ["subText"] = "Hammerspoon",
      ["action"]  = "l"
    },
    { ["text"]    = "K",
      ["subText"] = "Karabiner-Elements",
      ["action"]  = "l"
    },
    { ["text"]    = "L",
      ["subText"] = "Calendar",
      ["action"]  = "l"
    },
    {
      ["text"]     = "M",
      ["subText"]  = "Mail",
      ["action"]  = "l"
    },
    {
      ["text"]     = "N",
      ["subText"]  = "open -a /Applications/FirefoxDeveloperEdition.app https://admin.nsgroupllc.com/",
      ["action"]  = "e"
    },
    { ["text"]    = "P",
      ["subText"] = "Preview",
      ["action"]  = "l"
    },
    { ["text"]    = "S",
      ["subText"] = "Safari",
      ["action"]  = "l"
    },
    { ["text"]    = "T",
      ["subText"] = "iTerm",
      ["action"]  = "l"
    },
    {
      ["text"]     = "W",
      ["subText"]  = "open -a /Applications/Safari.app https://weather.com/weather/hourbyhour/l/USMI0028:1:US",
      ["action"]  = "e"
    },
}

local appChooser = hs.chooser.new(function(choice)
    if not choice then focusLastFocused(); return end
    if (choice.action == "l") then
        hs.application.launchOrFocus(choice.subText)
    else
        os.execute(choice.subText)
    end
end)
appChooser:bgDark(true)
appChooser:searchSubText(false)

hs.hotkey.bind(right_command, 'f19', function()
    if (appChooser:isVisible()) then
        appChooser:hide()
    else
        appChooser:choices(apps)
        appChooser:rows(5)
        appChooser:show()
        navigationMode:exit()
        -- ?? enter a mode here, where:
            -- pressing letter keys sends the letter, then enter
            -- pressing cmd+w, right_shift sends escape
    end
end)

-----------------
-- Window Chooser
-----------------
function getWindowList()
    -- TODO:
        -- Get Browser tabs
        -- Get windows from all spaces?
            -- see http://www.hammerspoon.org/docs/hs.window.filter.html
        -- Filter windows we'll never want
    local windows = hs.window.allWindows()
    windowlist = {}
    for _,win in pairs(windows) do
        table.insert(windowlist, 
            {
                ["text"] = win:title(),
                ["id"]   = win:id(),
            }
        )
    end
    return windowlist
end

local windowChooser = hs.chooser.new(function(choice)
    if not choice then focusLastFocused(); return end
    hs.window(choice.id):focus()
end)
windowChooser:bgDark(true)
windowChooser:searchSubText(true)

hs.hotkey.bind(right_command, 'w', function()
    if (windowChooser:isVisible()) then
        windowChooser:hide()
    else
        windowChooser:choices(getWindowList())
        navigationMode:exit()
        windowChooser:show()
        -- Unfortuantly, we don't seem to be able to clear the last search...
        -- windowChooser:query(nil)
        -- windowChooser:refreshChoicesCallback()
    end
end)
