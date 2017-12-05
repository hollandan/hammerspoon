functionMode = hs.hotkey.modal.new({}, 'F18')
-- functionMode:bind({}       , 'F19'    , function() functionMode:exit() end)
-- f19 should exit functionMode and open navigationMode
functionMode:bind({}       , 'escape' , function() functionMode:exit() end)
functionMode:bind({}       , 'f18'    , function() functionMode:exit() end)
functionMode:bind({}       , 'f17'    , function() functionMode:exit() end)
-- functionMode:bind({'ctrl'} , 'space'  , function() invokeITerm() end)

--should these be in windowTossing?
functionMode:bind({} , 'm' , function() showMissionControl() end)
functionMode:bind({} , '1' , function() goToDesktopOne() end)
functionMode:bind({} , '2' , function() goToDesktopTwo() end)
functionMode:bind({} , '3' , function() goToDesktopThree() end)


functionMode:bind({} , 'c' , function() capitalizeWord() end)
functionMode:bind({} , 'l' , function() lowercaseWord() end)
functionMode:bind({} , 'u' , function() uppercaseWord() end)

functionMode:bind({} , 'a' , function() appendText() end)

functionMode:bind({'shift'} , 't' , function() timeStamp() end)
functionMode:bind({}        , 'd' , function() dateStamp() end)
functionMode:bind({}        , 't' , function() showTime() end)

function timeStamp()
    local pasteboard = hs.pasteboard.getContents()
    stamp = hs.execute("date +'%m-%d-%Y %H:%M' | tr -d '\n' | pbcopy")
    hs.eventtap.keyStroke({'cmd'}, 'v')
    hs.pasteboard.setContents(pasteboard)
end

function dateStamp()
    local pasteboard = hs.pasteboard.getContents()
    stamp = hs.execute("date +'%m-%d-%Y' | tr -d '\n' | pbcopy")
    hs.eventtap.keyStroke({'cmd'}, 'v')
    hs.pasteboard.setContents(pasteboard)
end

function showTime()
    stamp = hs.execute("date +'%A %I:%M:%S %p' | tr -d '\n'")
    local style = hs.styledtext.new(stamp,{font={size=48}})
    -- local pos = hs.geometry.rect{0, 0, 300, 300}
    hs.alert.show(style, pos, 3)
    functionMode:exit()
end

functionMode:bind({} , 'space' , function() dotSpaceDash() end)


function functionMode:entered()
    -- if we can set and delete a rect... we can either use that or set another flag
    -- to tell if we were last in a certain mode, and make decisions
        -- for instance, go back to nav mode after function mode is done
    -- functionIndicator = hs.drawing.rectangle(hs.geometry.rect{0, 0, 6, 900})
    -- functionIndicator:setFill(true);
    -- functionIndicator:setFillColor({['red']=0,['blue']=1,['green']=0,['alpha']=1});
    -- functionIndicator:setStrokeColor({['red']=0,['blue']=1,['green']=0,['alpha']=1})
    -- functionIndicator:setStrokeWidth(1)
    -- functionIndicator:show()

    currentBorder = functionBorder
    currentIndicator:setStrokeColor(currentBorder);
end

function functionMode:exited()
    -- functionIndicator:delete()
    currentBorder = focusedBorder
    currentIndicator:setStrokeColor(currentBorder);

    -- -- This is probably a dumb way to do this... Is there a better way?
    -- nsgMenu Variables
    urltoadmin:disable()
    urltostructuredcontent:disable()
    urltodomain:disable()
    urltouri:disable()
    urltocontentpages:disable()
    urltospecificstructuredcontent:disable()
    urltospecificcontentpage:disable()
end

-- -- Change to DoubleCommand-Enter?
function showMissionControl()
    fastKeyStroke({'cmd', 'alt', 'ctrl', 'shift'}, 'f9')
    functionMode:exit()
end

-- function invokeITerm()
--     functionMode:exit()
--     fastKeyStroke({'ctrl'}, 'space')
-- end


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
    functionMode:exit()
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


functionMode:bind({} , 'n' , function() nsgMenu() end)
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

    hs.eventtap.keyStroke({'cmd'}, 'x')
    local currentapp = hs.application.frontmostApplication();
    hs.alert.show(currentapp:name())

    if (string.match(currentapp:name(), 'Safari') or string.match(currentapp:name(), 'Chrome') or string.match(currentapp:name(), 'Firefox')) then
        fastKeyStroke({'cmd'}, 'v')
        fastKeyStroke({'cmd'}, 't')
        fastKeyStroke({'cmd'}, 'l')
    end
    os.execute('python /Users/dan/pyscript/urltoadmin.py')
    hs.eventtap.keyStroke({'cmd'}, 'v')
    hs.eventtap.keyStroke({}, 'return')
    functionMode:exit()

    hs.pasteboard.setContents(pasteboard)
end

function urlToStructuredContent()
    local pasteboard = hs.pasteboard.getContents()

    hs.eventtap.keyStroke({'cmd'}, 'x')
    local currentapp = hs.application.frontmostApplication();
    if (string.match(currentapp:name(), 'Safari') or string.match(currentapp:name(), 'Chrome') or string.match(currentapp:name(), 'Firefox')) then
        fastKeyStroke({'cmd'}, 'v')
        fastKeyStroke({'cmd'}, 't')
        fastKeyStroke({'cmd'}, 'l')
    end
    os.execute('python /Users/dan/pyscript/urltostructuredcontent.py')
    hs.eventtap.keyStroke({'cmd'}, 'v')
    hs.eventtap.keyStroke({}, 'return')
    functionMode:exit()

    hs.pasteboard.setContents(pasteboard)
end

function urlToSpecificStructuredContent()
    local pasteboard = hs.pasteboard.getContents()
    hs.eventtap.keyStroke({'cmd'}, 'x')
    local currentapp = hs.application.frontmostApplication();
    if (string.match(currentapp:name(), 'Safari') or string.match(currentapp:name(), 'Chrome') or string.match(currentapp:name(), 'Firefox')) then
        fastKeyStroke({'cmd'}, 'v')
        fastKeyStroke({'cmd'}, 't')
        fastKeyStroke({'cmd'}, 'l')
    end
    os.execute('python /Users/dan/pyscript/urltostructuredcontent.py')
    hs.eventtap.keyStroke({'cmd'}, 'v')
    fastKeyStroke({'cmd'}, 'right')
    functionMode:exit()

    hs.pasteboard.setContents(pasteboard)
end

function urlToDomain()
    local pasteboard = hs.pasteboard.getContents()

    hs.eventtap.keyStroke({'cmd'}, 'x')
    local currentapp = hs.application.frontmostApplication();
    if (string.match(currentapp:name(), 'Safari') or string.match(currentapp:name(), 'Chrome') or string.match(currentapp:name(), 'Firefox')) then
        fastKeyStroke({'cmd'}, 'v')
        fastKeyStroke({'cmd'}, 't')
        fastKeyStroke({'cmd'}, 'l')
    end
    os.execute('python /Users/dan/pyscript/urltodomain.py')
    hs.eventtap.keyStroke({'cmd'}, 'v')
    hs.eventtap.keyStroke({}, 'return')
    functionMode:exit()

    hs.pasteboard.setContents(pasteboard)
end

function urlToContentPages()
    local pasteboard = hs.pasteboard.getContents()

    hs.eventtap.keyStroke({'cmd'}, 'x')
    local currentapp = hs.application.frontmostApplication();
    if (string.match(currentapp:name(), 'Safari') or string.match(currentapp:name(), 'Chrome') or string.match(currentapp:name(), 'Firefox')) then
        fastKeyStroke({'cmd'}, 'v')
        fastKeyStroke({'cmd'}, 't')
        fastKeyStroke({'cmd'}, 'l')
    end
    os.execute('python /Users/dan/pyscript/urltocontentpages.py')
    hs.eventtap.keyStroke({'cmd'}, 'v')
    hs.eventtap.keyStroke({}, 'return')
    functionMode:exit()

    hs.pasteboard.setContents(pasteboard)
end

function urlToSpecificContentPage()
    local pasteboard = hs.pasteboard.getContents()

    hs.eventtap.keyStroke({'cmd'}, 'x')
    local currentapp = hs.application.frontmostApplication();
    if (string.match(currentapp:name(), 'Safari') or string.match(currentapp:name(), 'Chrome') or string.match(currentapp:name(), 'Firefox')) then
        fastKeyStroke({'cmd'}, 'v')
        fastKeyStroke({'cmd'}, 't')
        fastKeyStroke({'cmd'}, 'l')
    end
    os.execute('python /Users/dan/pyscript/urltocontentpages.py')
    hs.eventtap.keyStroke({'cmd'}, 'v')
    hs.eventtap.keyStroke({'cmd'}, 'right')
    functionMode:exit()

    hs.pasteboard.setContents(pasteboard)
end

function urlToURI()
    local pasteboard = hs.pasteboard.getContents()

    hs.eventtap.keyStroke({'cmd'}, 'x')
    local currentapp = hs.application.frontmostApplication();
    os.execute('python /Users/dan/pyscript/urltouri.py')
    hs.eventtap.keyStroke({'cmd'}, 'v')
    hs.eventtap.keyStroke({}, 'return')
    functionMode:exit()

    hs.pasteboard.setContents(pasteboard)
end
--- ==========
