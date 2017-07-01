local fastKeyStroke = function(modifiers, character)
  local event = require("hs.eventtap").event
  event.newKeyEvent(modifiers, string.lower(character), true):post()
  event.newKeyEvent(modifiers, string.lower(character), false):post()
end

functionMode = hs.hotkey.modal.new({}, "F18")
-- functionMode:bind({}       , "F19"    , function() functionMode:exit() end)
-- f19 should exit functionMode and open navigationMode
functionMode:bind({}       , "escape" , function() functionMode:exit() end)
functionMode:bind({}       , "f18"    , function() functionMode:exit() end)
functionMode:bind({}       , "f17"    , function() functionMode:exit() end)
functionMode:bind({'ctrl'} , "space"  , function() invokeITerm() end)

--should these be in windowTossing?
functionMode:bind({} , "m" , function() showMissionControl() end)
functionMode:bind({} , "1" , function() goToDesktopOne() end)
functionMode:bind({} , "2" , function() goToDesktopTwo() end)
functionMode:bind({} , "3" , function() goToDesktopThree() end)


functionMode:bind({} , "c" , function() capitalizeWord() end)
functionMode:bind({} , "l" , function() lowercaseWord() end)
functionMode:bind({} , "u" , function() uppercaseWord() end)

functionMode:bind({} , "a" , function() appendText() end)

functionMode:bind({'shift'} , "t" , function() timeStamp() end)
functionMode:bind({}        , "d" , function() dateStamp() end)
functionMode:bind({}        , "t" , function() showTime() end)

function timeStamp()
    stamp = hs.execute("date +'%d-%m-%Y %H:%M' | tr -d '\n' | pbcopy")
    hs.eventtap.keyStroke({'cmd'}, 'v')
end

function dateStamp()
    stamp = hs.execute("date +'%d-%m-%Y' | tr -d '\n' | pbcopy")
    hs.eventtap.keyStroke({'cmd'}, 'v')
end

function showTime()
    stamp = hs.execute("date +'%A %I:%M:%S %p' | tr -d '\n'")
    local style = hs.styledtext.new(stamp,{font={size=48}})
    -- local pos = hs.geometry.rect{0, 0, 300, 300}
    hs.alert.show(style, pos, 3)
    functionMode:exit()
end

functionMode:bind({} , "space" , function() dotSpaceDash() end)


function functionMode:entered()
    -- if we can set and delete a rect... we can either use that or set another flag
    -- to tell if we were last in a certain mode, and make decisions
        -- for instnace, go back to nav mode after function mode is done
    functionIndicator = hs.drawing.rectangle(hs.geometry.rect{0, 0, 6, 900})
    functionIndicator:setFill(true);
    functionIndicator:setFillColor({["red"]=0,["blue"]=1,["green"]=0,["alpha"]=1});
    functionIndicator:setStrokeColor({["red"]=0,["blue"]=1,["green"]=0,["alpha"]=1})
    functionIndicator:setStrokeWidth(1)

    functionIndicator:show()
end

function functionMode:exited()
    functionIndicator:delete()

    -- -- This is probably a dumb way to do this... Is there a better way?
    -- nsgMenu Variables
    urltoadmin:disable()
    urltostructuredcontent:disable()
    urltodomain:disable()
    urltocontentpages:disable()
    urltospecificstructuredcontent:disable()
    urltospecificcontentpage:disable()
end

function showMissionControl()
    fastKeyStroke({'cmd', 'alt', 'ctrl', 'shift'}, 'f9')
    functionMode:exit()
end

function goToDesktopOne()
    fastKeyStroke({'cmd', 'alt', 'ctrl'}, "1")
    functionMode:exit()
end

function goToDesktopTwo()
    fastKeyStroke({'cmd', 'alt', 'ctrl'}, "2")
    functionMode:exit()
end

function goToDesktopThree()
    fastKeyStroke({'cmd', 'alt', 'ctrl'}, "3")
    functionMode:exit()
end



function invokeITerm()
    functionMode:exit()
    fastKeyStroke({'ctrl'}, "space")
end


function capitalizeWord()
    hs.eventtap.keyStroke({'ctrl', 'shift'}, "\\")
    -- wtf? we can't have an empty modifier here. If we do, the following eventtap just doesn't fire
        -- so... let's use fn as a modifier, since it doesn't effectively change the key
    hs.eventtap.keyStroke({'fn'}, "c")
    functionMode:exit()
end

function lowercaseWord()
    hs.eventtap.keyStroke({'ctrl', 'shift'}, "\\")
    hs.eventtap.keyStroke({'fn'}, "l")
    functionMode:exit()
end

function uppercaseWord()
    hs.eventtap.keyStroke({'ctrl', 'shift'}, "\\")
    hs.eventtap.keyStroke({'fn'}, "u")
    functionMode:exit()
end

function appendText()
    fastKeyStroke({'ctrl'}, "7")
    functionMode:exit()
end


function dotSpaceDash()

    --check out hs.eventtap.keyStrokes() for this..
    -- http://www.hammerspoon.org/docs/hs.eventtap.html#keyStrokes

    -- preserve the pasteboard?
    -- local pasteboard = hs.pasteboard.getContents()

    --select the text on the line
    -- hs.eventtap.keyStrokes('abcd')
    -- fastKeyStroke({'cmd'}, 'right')
    -- fastKeyStroke({'cmd', 'shift'}, 'left')
    -- fastKeyStroke({'cmd'}, 'c')
    -- os.execute("sleep 2")

    -- local text = hs.uielement.focusedElement():selectedText()

    local text = hs.pasteboard.getContents()

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

    -- is there a better way than occupying the pasteboard?
    hs.pasteboard.setContents(string.lower(text))
    -- fastKeyStroke({'cmd'}, 'right')
    -- fastKeyStroke({'cmd', 'shift'}, 'left')
    hs.eventtap.keyStroke({'cmd'}, 'v')

    -- hs.pasteboard.setContents(pasteboard)
    functionMode:exit()
end


functionMode:bind({} , 'n' , function() nsgMenu() end)
function nsgMenu()
    urltoadmin                     = hs.hotkey.bind({}, 'a', function() urlToAdmin() end)
    urltostructuredcontent         = hs.hotkey.bind({}, 's', function() urlToStructuredContent() end)
    urltodomain                    = hs.hotkey.bind({}, 'd', function() urlToDomain() end)
    urltocontentpages              = hs.hotkey.bind({}, 'c', function() urlToContentPages() end)
    urltospecificstructuredcontent = hs.hotkey.bind({}, 't', function() urlToSpecificStructuredContent() end)
    urltospecificcontentpage       = hs.hotkey.bind({}, 'p', function() urlToSpecificContentPage() end)
end

function urlToAdmin()
    hs.eventtap.keyStroke({'cmd'}, 'x')
    local currentapp = hs.application.frontmostApplication();
    if (currentapp:name() == 'Safari' or currentapp:name() == 'Firefox' or currentapp.name() == 'Chrome') then
        fastKeyStroke({'cmd'}, 't')
        fastKeyStroke({'cmd'}, 'l')
    end
    os.execute('python /Users/dan/pyscript/urltoadmin.py')
    hs.eventtap.keyStroke({'cmd'}, 'v')
    hs.eventtap.keyStroke({}, 'return')
    functionMode:exit()
end

function urlToStructuredContent()
    hs.eventtap.keyStroke({'cmd'}, 'x')
    local currentapp = hs.application.frontmostApplication();
    if (currentapp:name() == 'Safari' or currentapp:name() == 'Firefox' or currentapp.name() == 'Chrome') then
        fastKeyStroke({'cmd'}, 't')
        fastKeyStroke({'cmd'}, 'l')
    end
    os.execute('python /Users/dan/pyscript/urltostructuredcontent.py')
    hs.eventtap.keyStroke({'cmd'}, 'v')
    hs.eventtap.keyStroke({}, 'return')
    functionMode:exit()
end

function urlToSpecificStructuredContent()
    hs.eventtap.keyStroke({'cmd'}, 'x')
    local currentapp = hs.application.frontmostApplication();
    if (currentapp:name() == 'Safari' or currentapp:name() == 'Firefox' or currentapp.name() == 'Chrome') then
        fastKeyStroke({'cmd'}, 't')
        fastKeyStroke({'cmd'}, 'l')
    end
    os.execute('python /Users/dan/pyscript/urltostructuredcontent.py')
    hs.eventtap.keyStroke({'cmd'}, 'v')
    fastKeyStroke({'cmd'}, 'right')
    functionMode:exit()
end

function urlToDomain()
    hs.eventtap.keyStroke({'cmd'}, 'x')
    local currentapp = hs.application.frontmostApplication();
    if (currentapp:name() == 'Safari' or currentapp:name() == 'Firefox' or currentapp.name() == 'Chrome') then
        fastKeyStroke({'cmd'}, 't')
        fastKeyStroke({'cmd'}, 'l')
    end
    os.execute('python /Users/dan/pyscript/urltodomain.py')
    hs.eventtap.keyStroke({'cmd'}, 'v')
    hs.eventtap.keyStroke({}, 'return')
    functionMode:exit()
end

function urlToContentPages()
    hs.eventtap.keyStroke({'cmd'}, 'x')
    local currentapp = hs.application.frontmostApplication();
    if (currentapp:name() == 'Safari' or currentapp:name() == 'Firefox' or currentapp.name() == 'Chrome') then
        fastKeyStroke({'cmd'}, 't')
        fastKeyStroke({'cmd'}, 'l')
    end
    os.execute('python /Users/dan/pyscript/urltocontentpages.py')
    hs.eventtap.keyStroke({'cmd'}, 'v')
    hs.eventtap.keyStroke({}, 'return')
    functionMode:exit()
end

function urlToSpecificContentPage()
    hs.eventtap.keyStroke({'cmd'}, 'x')
    local currentapp = hs.application.frontmostApplication();
    if (currentapp:name() == 'Safari' or currentapp:name() == 'Firefox' or currentapp.name() == 'Chrome') then
        fastKeyStroke({'cmd'}, 't')
        fastKeyStroke({'cmd'}, 'l')
    end
    -- os.execute('python /Users/dan/pyscript/urltospecificcontentpage.py')
    os.execute('python /Users/dan/pyscript/urltocontentpages.py')
    hs.eventtap.keyStroke({'cmd'}, 'v')
    hs.eventtap.keyStroke({'cmd'}, 'right')
    functionMode:exit()
end
--- ==========
