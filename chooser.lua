-- Reference: https://aldur.github.io/articles/hammerspoon-emojis/
-- Focus the last used window.
local function focusLastFocused()
    local wf = hs.window.filter
    local lastFocused = wf.defaultCurrentSpace:getWindows(wf.sortByFocusedLast)
    if #lastFocused > 0 then lastFocused[1]:focus() end
end

-- a b g o q u x y z
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
    { ["text"]    = "CA",
      ["subText"] = "Calendar",
      ["action"]  = "l"
    },
    { ["text"]    = "CHILL",
      ["subText"] = "~/dotfiles/personal/scripts/ichill",
      ["action"]  = "e"
    },
    { ["text"]    = "D",
      ["subText"] = "Cyberduck",
      ["action"]  = "l"
    },
    { ["text"]    = "E",
      ["subText"] = "TextEdit",
      ["action"]  = "l"
    },
    {
      ["text"]    = "F",
      ["subText"] = "Firefox",
      ["action"]  = "l"
    },
    { ["text"]    = "H",
      ["subText"] = "Hammerspoon",
      ["action"]  = "l"
    },
    {
      ["text"]    = "I",
      ["subText"] = "iTunes",
      ["action"]  = "l"
    },
    { ["text"]    = "J",
      ["subText"] = "open -a '/Applications/Google Chrome.app' https://calendar.google.com/calendar/r",
      ["action"]  = "e"
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
      ["text"]    = "M",
      ["subText"] = "Mail",
      ["action"]  = "l"
    },
    {
      ["text"]    = "MA",
      ["subText"] = "Mail",
      ["action"]  = "l"
    },
    {
      ["text"]    = "ME",
      ["subText"] = "Messages",
      ["action"]  = "l"
    },
    {
      ["text"]    = "N",
      ["subText"] = "open -a /Applications/Firefox.app https://admin.nsgroupllc.com/",
      ["action"]  = "e"
    },
    {
      ["text"]    = "O",
      -- ["subText"] = "open -a /Applications/Safari.app https://rainwave.cc/ocremix/",
      ["subText"] = "open -a '/Applications/Google Chrome.app' https://rainwave.cc/ocremix/",
      ["action"]  = "e"
    },
    { ["text"]    = "P",
      ["subText"] = "Preview",
      ["action"]  = "l"
    },
    {
      ["text"]    = "R",
      -- ["subText"] = "open -a /Applications/Safari.app http://player.radiocoalition.org/mountainchill?l&autoplay=1",
      ["subText"] = "open -a '/Applications/Google Chrome.app' http://player.radiocoalition.org/mountainchill?l&autoplay=1",
      ["action"]  = "e"
    },
    { ["text"]    = "S",
      ["subText"] = "Safari",
      ["action"]  = "l"
    },
    { ["text"]    = "T",
      ["subText"] = "iTerm",
      ["action"]  = "l"
    },
    { ["text"]    = "V",
      ["subText"] = "Karabiner-EventViewer",
      ["action"]  = "l"
    },
    {
      ["text"]    = "W",
      ["subText"] = "open -a /Applications/Safari.app https://weather.com/weather/hourbyhour/l/USMI0028:1:US",
      ["action"]  = "e"
    },
}

local appChooser = hs.chooser.new(function(choice)
    if not choice then focusLastFocused(); return end
    -- if not choice then os.execute("~/dotfiles/personal/scripts/ichill"); return end
    if (choice.action == "l") then
        hs.application.launchOrFocus(choice.subText)
    elseif (choice.action == "e") then
        os.execute(choice.subText)
    end
end)

appChooser:bgDark(true)
appChooser:searchSubText(false)
appChooser:width(50)

-- launch chooser outside of terminal
hs.hotkey.bind(right_command, 'f19', function() launchChooser() end)
-- lauch chooser inside of terminal
hs.hotkey.bind(right_command, 'escape', function() launchChooser() end)

function launchChooser()
    if (appChooser:isVisible()) then
        appChooser:hide()
    else
        appChooser:choices(apps)
        appChooser:rows(1)
        navigationMode:exit()
        local topleftpoint = hs.geometry.point(
            hs.screen.mainScreen():frame().w*.25,
            0
        )
        appChooser:show(topleftpoint)
        -- appChooser:query('') will clear the query... but leaves only one item selected
        -- But, this clears the query AND shows all options
        hs.eventtap.keyStroke({}, "delete")

        -- ?? enter a mode here, where:
            -- pressing letter keys sends the letter, then enter
            -- pressing cmd+w, right_shift sends escape
    end
end


-----------------
-- Window Chooser
-----------------
function getChooserWindowList()
    -- TODO:
        -- Get Browser tabs
            -- see https://github.com/ashfinal/awesome-hammerspoon/blob/master/modes/hsearch.lua
        -- Get windows from all spaces?
            -- see http://www.hammerspoon.org/docs/hs.window.filter.html
        -- Ignore windows we'll never want
        -- Might want to use globabl allwindows for this...
    local windows = hs.window.allWindows()
    windowlist = {}
    for _,win in pairs(windows) do
        if win:title() ~= "" then
            table.insert(windowlist, 
                {
                    ["text"] = win:title(),
                    ["id"]   = win:id(),
                }
            )
        end
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
        windowChooser:choices(getChooserWindowList())
        navigationMode:exit()
        windowChooser:show()
        -- windowChooser:query('') will clear the query... but leaves only one item selected
        -- But, this clears the query AND shows all options
        hs.eventtap.keyStroke({}, "delete")
    end
end)
