functionMode = hs.hotkey.modal.new({}, 'F18')
functionMode:bind({} , 'escape' , function() functionMode:exit() end)
functionMode:bind({} , 'f18'    , function() functionMode:exit() end)
functionMode:bind({} , 'f17'    , function() functionMode:exit() end)

--should these be in windowTossing?
functionMode:bind({} , '1' , function() goToDesktopOne() end)
functionMode:bind({} , '2' , function() goToDesktopTwo() end)
functionMode:bind({} , '3' , function() goToDesktopThree() end)

functionMode:bind({} , 'a' , function() appendText() end)
functionMode:bind({} , 's' , function() badAssMenu() end)
functionMode:bind({} , 'd' , function() dateStamp() end)
functionMode:bind({} , 'f' , function() moveFocusMenuHelp() end)

functionMode:bind({} , 'j' , function() toggleJavascriptInBrowser() end)

functionMode:bind({} , 'l' , function() lowercaseWord() end)
functionMode:bind({} , 'c' , function() capitalizeWord() end)
functionMode:bind({} , 'u' , function() uppercaseWord() end)

functionMode:bind({} , 'n' , function() nsgMenu() end)
functionMode:bind({} , 'm' , function() showMissionControl() end)

functionMode:bind({} , 'space' , function() dotSpaceDash() end)

functionMode:bind({} , 't' , function() showTime() end)
    functionMode:bind({'shift'} , 't' , function() timeStamp() end)

-- functionMode:bind({} , 'w' , function() windowMenu() end)

functionMode:bind({} , 'x' , function() moveFocusToStatusBar() end)
functionMode:bind({} , 'z' , function() moveFocusToMenuBar() end)


function functionMode:entered()
    currentColor = functionColor
    if currentIndicator ~= nil then
        currentIndicator:setStrokeColor(currentColor);
    end
    dashboard[1] = {
        type = "rectangle",
        fillColor = functionColor
    }
end

function functionMode:exited()
    currentColor = focusedColor
    if currentIndicator ~= nil then
        currentIndicator:setStrokeColor(currentColor);
    end
    dashboard[1] = {
        type = "rectangle",
        fillColor = darkColor
    }

    -- -- This is probably a dumb way to do this... Is there a better way?
    -- nsgMenu Variables
    urltoadmin:disable()
    urltostructuredcontent:disable()
    urltodomain:disable()
    urltouri:disable()
    urltocontentpages:disable()
    urltospecificstructuredcontent:disable()
    urltospecificcontentpage:disable()

    windowsalignvertical:disable()
    windowsalignhorizontal:disable()

end

function timeStamp()
    local pasteboard = hs.pasteboard.getContents()
    stamp = hs.execute("date +'%m-%d-%Y %H:%M' | tr -d '\n' | pbcopy")
    hs.eventtap.keyStroke({'cmd'}, 'v')
    hs.pasteboard.setContents(pasteboard)
    functionMode:exit()
end

function dateStamp()
    local pasteboard = hs.pasteboard.getContents()
    stamp = hs.execute("date +'%m-%d-%Y' | tr -d '\n' | pbcopy")
    hs.eventtap.keyStroke({'cmd'}, 'v')
    hs.pasteboard.setContents(pasteboard)
    functionMode:exit()
end

function showTime()
    stamp = hs.execute("date +'%A %I:%M:%S %p' | tr -d '\n'")
    local style = hs.styledtext.new(stamp,{font={size=48}})
    -- local pos = hs.geometry.rect{0, 0, 300, 300}
    hs.alert.show(style, pos, 3)
    functionMode:exit()
end


-- -- Change to DoubleCommand-Enter?
function showMissionControl()
    fastKeyStroke({'cmd', 'alt', 'ctrl', 'shift'}, 'f9')
    functionMode:exit()
end

function capitalizeWord()
    hs.eventtap.keyStroke({'ctrl', 'shift'}, "\\")
    -- wtf? we can't have an empty modifier here. If we do, the following eventtap just doesn't fire
        -- so... let's use fn as a modifier, since it doesn't effectively change the key
    hs.eventtap.keyStroke({'fn'}, 'c')
    functionMode:exit()
end

function lowercaseWord()
    hs.eventtap.keyStroke({'ctrl', 'shift'}, "\\")
    hs.eventtap.keyStroke({'fn'}, 'l')
    functionMode:exit()
end

function uppercaseWord()
    hs.eventtap.keyStroke({'ctrl', 'shift'}, "\\")
    hs.eventtap.keyStroke({'fn'}, 'u')
    functionMode:exit()
end

function appendText()
    fastKeyStroke({'ctrl'}, '7')
    navigationMode:exit()
    functionMode:exit()
end

function badAssMenu()
    fastKeyStroke({'ctrl', 'shift'}, '\\')
    functionMode:exit()
end


function moveFocusToMenuBar()
    functionMode:exit()
    fastKeyStroke({'ctrl', 'fn'}, "F2")
end

function moveFocusToStatusBar()
    functionMode:exit()
    -- fastKeyStroke({'ctrl', 'fn'}, "F2")
    fastKeyStroke({'ctrl', 'fn'}, "F8")
    navigationMode:enter()
end

function moveFocusMenuHelp()
    functionMode:exit()
    fastKeyStroke({'ctrl', 'fn'}, "F2")
    fastKeyStroke({}, "left")
    fastKeyStroke({}, "down")
end


function dotSpaceDash()

    local text = hs.pasteboard.getContents()

    hs.eventtap.keyStroke({'cmd'}, 'c')
    hs.eventtap.keyStroke({'cmd'}, 'left')
    hs.eventtap.keyStroke({'cmd', 'shift'}, 'right')

    local _, dash = string.gsub(text, "%-", "")
    local _, space = string.gsub(text, " ", "")
    local _, uscore = string.gsub(text, "_", "")

    if (dash > space and dash > uscore) then
        text = string.gsub(text, "%-", "_")
        text = string.gsub(text, " ", "_")
    elseif (space > dash and space > uscore) then
        text = string.gsub(text, " ", "-")
        text = string.gsub(text, "_", "-")
    elseif (uscore > dash and uscore > space) then
        text = string.gsub(text, "_", " ")
        text = string.gsub(text, "-", " ")
    end

    hs.pasteboard.setContents(string.lower(text))
    hs.eventtap.keyStroke({'cmd'}, 'v')
    functionMode:exit()
end


function nsgMenu()
    urltoadmin                     = hs.hotkey.bind({}, 'a', function() urlToAdmin() end)
    urltostructuredcontent         = hs.hotkey.bind({}, 's', function() urlToStructuredContent() end)
    urltodomain                    = hs.hotkey.bind({}, 'd', function() urlToDomain() end)
    urltocontentpages              = hs.hotkey.bind({}, 'c', function() urlToContentPages() end)
    urltospecificstructuredcontent = hs.hotkey.bind({}, 't', function() urlToSpecificStructuredContent() end)
    urltospecificcontentpage       = hs.hotkey.bind({}, 'p', function() urlToSpecificContentPage() end)
    urltouri                       = hs.hotkey.bind({}, 'u', function() urlToURI() end)
end

function urlToAdmin()

    local pasteboard = hs.pasteboard.getContents()

    local currentapp = hs.application.frontmostApplication();
    hs.alert.show(currentapp:name())

    if (string.match(currentapp:name(), 'Safari') or string.match(currentapp:name(), 'Chrome') or string.match(currentapp:name(), 'Firefox')) then
        hs.eventtap.keyStroke({'cmd'}, 'l')
        hs.eventtap.keyStroke({'cmd'}, 'x')
        hs.eventtap.keyStroke({'cmd'}, 'v')
        hs.eventtap.keyStroke({'cmd'}, 't')
        hs.eventtap.keyStroke({'cmd'}, 'l')
        os.execute('python /Users/dan/pyscript/urltoadmin.py')
        hs.eventtap.keyStroke({'cmd'}, 'v')
        hs.eventtap.keyStroke({}, 'return')
    end
    functionMode:exit()

    hs.pasteboard.setContents(pasteboard)
end

function urlToStructuredContent()
    local pasteboard = hs.pasteboard.getContents()

    local currentapp = hs.application.frontmostApplication();
    if (string.match(currentapp:name(), 'Safari') or string.match(currentapp:name(), 'Chrome') or string.match(currentapp:name(), 'Firefox')) then
        hs.eventtap.keyStroke({'cmd'}, 'l')
        hs.eventtap.keyStroke({'cmd'}, 'x')
        hs.eventtap.keyStroke({'cmd'}, 'v')
        hs.eventtap.keyStroke({'cmd'}, 't')
        hs.eventtap.keyStroke({'cmd'}, 'l')
        os.execute('python /Users/dan/pyscript/urltostructuredcontent.py')
        hs.eventtap.keyStroke({'cmd'}, 'v')
        hs.eventtap.keyStroke({}, 'return')
    end
    functionMode:exit()

    hs.pasteboard.setContents(pasteboard)
end

function urlToSpecificStructuredContent()
    local pasteboard = hs.pasteboard.getContents()

    local currentapp = hs.application.frontmostApplication();
    if (string.match(currentapp:name(), 'Safari') or string.match(currentapp:name(), 'Chrome') or string.match(currentapp:name(), 'Firefox')) then
        hs.eventtap.keyStroke({'cmd'}, 'l')
        hs.eventtap.keyStroke({'cmd'}, 'x')
        hs.eventtap.keyStroke({'cmd'}, 'v')
        hs.eventtap.keyStroke({'cmd'}, 't')
        hs.eventtap.keyStroke({'cmd'}, 'l')
        os.execute('python /Users/dan/pyscript/urltostructuredcontent.py')
        hs.eventtap.keyStroke({'cmd'}, 'v')
        hs.eventtap.keyStroke({}, 'return')
    end
    functionMode:exit()

    hs.pasteboard.setContents(pasteboard)
end

function urlToDomain()
    local pasteboard = hs.pasteboard.getContents()

    os.execute('python /Users/dan/pyscript/urltodomain.py')
    hs.eventtap.keyStroke({'cmd'}, 'v')
    functionMode:exit()

    hs.pasteboard.setContents(pasteboard)
end

function urlToContentPages()
    local pasteboard = hs.pasteboard.getContents()

    local currentapp = hs.application.frontmostApplication();
    if (string.match(currentapp:name(), 'Safari') or string.match(currentapp:name(), 'Chrome') or string.match(currentapp:name(), 'Firefox')) then
        hs.eventtap.keyStroke({'cmd'}, 'l')
        hs.eventtap.keyStroke({'cmd'}, 'x')
        hs.eventtap.keyStroke({'cmd'}, 'v')
        hs.eventtap.keyStroke({'cmd'}, 't')
        hs.eventtap.keyStroke({'cmd'}, 'l')
        os.execute('python /Users/dan/pyscript/urltocontentpages.py')
        hs.eventtap.keyStroke({'cmd'}, 'v')
        hs.eventtap.keyStroke({}, 'return')
    end
    functionMode:exit()

    hs.pasteboard.setContents(pasteboard)
end

function urlToSpecificContentPage()
    local pasteboard = hs.pasteboard.getContents()

    local currentapp = hs.application.frontmostApplication();
    if (string.match(currentapp:name(), 'Safari') or string.match(currentapp:name(), 'Chrome') or string.match(currentapp:name(), 'Firefox')) then
        hs.eventtap.keyStroke({'cmd'}, 'l')
        hs.eventtap.keyStroke({'cmd'}, 'x')
        hs.eventtap.keyStroke({'cmd'}, 'v')
        hs.eventtap.keyStroke({'cmd'}, 't')
        hs.eventtap.keyStroke({'cmd'}, 'l')
        os.execute('python /Users/dan/pyscript/urltocontentpages.py')
        hs.eventtap.keyStroke({'cmd'}, 'v')
        hs.eventtap.keyStroke({'cmd'}, 'right')
    end
    functionMode:exit()

    hs.pasteboard.setContents(pasteboard)
end

function urlToURI()
    local pasteboard = hs.pasteboard.getContents()

    os.execute('python /Users/dan/pyscript/urltouri.py')
    hs.eventtap.keyStroke({'cmd'}, 'v')
    functionMode:exit()

    hs.pasteboard.setContents(pasteboard)
end
--- ==========



function windowsAlignHorizontal()
    alterWindows()
    functionMode:exit()
end
function windowsAlignVertical()
    balanceWindows()
    functionMode:exit()
end
function windowMenu()
    windowsalignhorizontal = hs.hotkey.bind({}, 'a', function() windowsAlignHorizontal() end)
    windowsalignvertical   = hs.hotkey.bind({}, 'b', function() windowsAlignVertical() end)
end

-- toggle javascript in browsers
function toggleJavascriptInBrowser()

    functionMode:exit()
    local app = hs.application.frontmostApplication():name();
    if string.match(app , 'Firefox') or string.match(app , 'Firefox Developer Edition') then
        hs.eventtap.keyStroke({'cmd'}, 't')
        hs.eventtap.keyStrokes("about:config")
        hs.timer.usleep(600)
        hs.eventtap.keyStroke({}, 'return')
        hs.eventtap.keyStrokes("javascript.enabled")
        hs.timer.usleep(800)
        hs.eventtap.keyStroke({}, 'return')
        hs.eventtap.keyStroke({}, 'tab')
        hs.eventtap.keyStroke({}, 'return')
        hs.eventtap.keyStroke({'cmd'}, 'w')

    elseif string.match(app , 'Google Chrome') then
        hs.eventtap.keyStroke({'cmd'}, 't')
        hs.eventtap.keyStrokes("chrome://settings/content/javascript")
        hs.timer.usleep(1000)
        hs.eventtap.keyStroke({}, 'return')

        -- there's some goofy delay here while chrome forces focus on the 
        -- "Search Settings" bar. Hitting cmd-l 4 times seems to eat the delay
        hs.eventtap.keyStroke({'cmd'}, 'l')
        hs.eventtap.keyStroke({'cmd'}, 'l')
        hs.eventtap.keyStroke({'cmd'}, 'l')
        hs.eventtap.keyStroke({'cmd'}, 'l')

        -- the amount of times you need to hit tab depend on the width of the
        -- window. But, you can always reach the desired field by hitting
        -- shift-tab 3 times
        hs.eventtap.keyStroke({"shift"}, 'tab')
        hs.eventtap.keyStroke({"shift"}, 'tab')
        hs.eventtap.keyStroke({"shift"}, 'tab')

        hs.eventtap.keyStroke({}, 'return')

        hs.eventtap.keyStroke({'cmd'}, 'w')

    elseif string.match(app , 'Safari') then
        hs.osascript.applescript([[
        tell application "System Events"
            tell process "Safari"
                set frontmost to true
                click menu item "Disable JavaScript" of menu "Develop" of menu bar 1
            end tell
        end tell
        ]])
    else
        hs.alert.show("Not in browser; js not toggled.")
    end

end
