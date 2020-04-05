-- Reference: https://aldur.github.io/articles/hammerspoon-emojis/
-- Focus the last used window.
local function focusLastFocused()
    local wf = hs.window.filter
    local lastFocused = wf.defaultCurrentSpace:getWindows(wf.sortByFocusedLast)
    if #lastFocused > 0 then lastFocused[1]:focus() end
end

-- Leftovers:
-- a b g o q u x y z
-----------------
-- App Chooser
-----------------
    -- actions:
        --  l => Launch
        --  e => Execute
        --  f => Call Function
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
      ["subText"] = "~/dotfiles/mac/scripts/ichill",
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
      ["subText"] = "open -a '/Applications/Karabiner-Elements.app'",
      ["action"]  = "e"
    },
    {
        ["text"]    = "Karate Camera 1",
        ["subText"] = "open -a '/Applications/Google Chrome.app' https://drive.google.com/drive/folders/1bgtgZ_XKjPIfnk2tWfbR6n8_dp6Pskhj",
        ["action"]  = "e"
    },
    {
        ["text"]    = "Karate Camera 2",
        ["subText"] = "open -a '/Applications/Google Chrome.app' https://drive.google.com/drive/folders/1w5azDERsZzYPuDG9NEuAmcNWZP3XSRXk",
        ["action"]  = "e"
    },
    {
        ["text"]    = "Karate Camera 3",
        ["subText"] = "open -a '/Applications/Google Chrome.app' https://drive.google.com/drive/folders/1Idae6v7sJ3u8MOu-mwQy5UGCU3f-flVW",
        ["action"]  = "e"
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
      ["text"]    = "MS",
      ["subText"] = "searchMailFullScreen",
      ["action"]  = "f"
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
    {
        ["text"]    = "SEO",
        ["subText"] = "open -a '/Applications/Safari.app' https://us04web.zoom.us/j/260636668?pwd=QUtNTkxUVUNiNjJvUEU1Q0xQOHVMZz09",
        ["action"]  = "e"
    },
    { ["text"]    = "SHUFFLE",
      ["subText"] = "~/dotfiles/mac/scripts/itunes shuffle",
      ["action"]  = "e"
    },
    {
        ["text"]    = "Stream Karate",
        ["subText"] = "open -a '/Applications/Safari.app' https://us04web.zoom.us/j/491767877?pwd=NHRzcGY5Y1VrZWF2ZDQ3NXV6ejNGQT09",
        ["action"]  = "e"
    },
    {
        ["text"]    = "Stream Iaido",
        ["subText"] = "open -a '/Applications/Safari.app' https://us04web.zoom.us/j/135327455?pwd=cmtBWWFkVGxQNmliYkRHZmFSdkhVUT09",
        ["action"]  = "e"
    },
    {
        ["text"]    = "Stream Judo/Jujutsu",
        ["subText"] = "open -a '/Applications/Safari.app' https://us04web.zoom.us/j/333957545?pwd=azBOUGJpNTNacFo3Sk8xbkppSGRkUT09",
        ["action"]  = "e"
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
    {
      ["text"]    = "x",
      ["subText"] = "open -a '/Applications/Google Chrome.app' https://login.xfinity.com/login",
      ["action"]  = "e"
    },
}

local appChooser = hs.chooser.new(function(choice)
    if not choice then focusLastFocused(); return end
    if (choice.action == "l") then
        hs.application.launchOrFocus(choice.subText)
    elseif (choice.action == "e") then
        os.execute(choice.subText)
    elseif (choice.action == "f") then
        _G[choice.subText]()
    end
end)

appChooser:bgDark(true)
appChooser:searchSubText(false)
appChooser:width(50)

-- launch chooser outside of terminal
hs.hotkey.bind(right_command, 'f19', function() launchChooser() end)

----this would be awesome if we could bind the keystroke 
--    -- ONLY TO !iterm2
---- but, it appears that this will intercept the keystroke in iTerm2
---- makeing the bind unusable there.
-- hs.hotkey.bind(right_command, 'o', function()
--     local currentapp = hs.application.frontmostApplication()
--     if (not string.match(currentapp:name(), 'iTerm2')) then
--         launchChooser()
--     else
--         // open recent in iterm
--         hs.eventtap.keyStroke({'ctrl', 'shift', 'option'}, 'o')
--     end
-- end)

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
    showBorders()
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

function searchMailFullScreen()
    hs.osascript.applescript([[
    tell application "System Events"
        tell process "Mail"
            set frontmost to true
            click menu item "New Viewer Window" of menu "File" of menu bar 1
            click menu item "Enter Full Screen" of menu "View" of menu bar 1
            click menu item "Mailbox Search" of it's menu of menu item "Find" of it's menu of menu bar item "Edit" of menu bar 1
        end tell
    end tell
    ]])
end
