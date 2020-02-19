function editInTerminalVim(arg)
    local savedclipboard = hs.pasteboard.getContents()

    local win = hs.window.focusedWindow()
    local id    = hs.window.focusedWindow():id()
    local title = id .. "," .. hs.window.focusedWindow():title()
    title = string.gsub(title, " ", "-")
    -- title = string.gsub(title, "—", "-")
    -- hs.alert.show(title)

    hs.eventtap.keyStroke({'cmd'}, 'c')
    local copiedclipboard = hs.pasteboard.getContents()
    hs.pasteboard.setContents(copiedclipboard)

    local filename = '"/Users/dan/.editinvim/' .. title .. '"'
    local command = 'pbpaste | textutil -stdin -format txt -convert txt -output ' .. filename

    os.execute(command)

    -- hs.pasteboard.setContents(command)
    hs.pasteboard.setContents(savedclipboard)

    local begin  = [[
        tell application "iTerm"
            activate

    ]]

    local middle
    if     arg == "v" then middle = "tell current session of current window to split vertically with default profile"
    elseif arg == "h" then middle = "tell current session of current window to split horizontally with default profile"
    else                   middle = "tell current window to create tab with default profile"
    end

    local last  = [[

            tell current tab of current window
                set _new_session to last item of sessions
            end tell
            tell _new_session
                select
                write text ("exec editinvim; exit")
            end tell
        end tell
    ]]

    hs.osascript.applescript(begin..middle..last)
    -- os.execute("sleep 3 && /bin/rm " .. filename .. " &")
end

hs.hotkey.bind(double_command, '\\', function()
    editInTerminalVim("v")
    hs.eventtap.keyStroke({'ctrl'}, 'space')
end)

hs.hotkey.bind(double_command, 'g', function()
    editInTerminalVim("h")
    hs.eventtap.keyStroke({'ctrl'}, 'space')
end)

hs.hotkey.bind(double_command, 'tab', function()
    editInTerminalVim("")
    hs.eventtap.keyStroke({'ctrl'}, 'space')
end)

-- ~/dotfiles/vim/bundle/mine/ftplugin/editinvim.vim

function pasteFromVim(title)
    local id = string.match(title, "(.*),")

    -- -- if the window is no longer around, do something else
    -- if pcall(hs.window.get(tonumber(id)) then
    --     local win = hs.window.get(tonumber(id))
    --     ...
    -- else
    --     -- `foo' raised an error: take appropriate actions
    --     ...
    -- end


    local win = hs.window.get(tonumber(id))


    local savedclipboard = hs.pasteboard.getContents()
    local filename = '"/Users/dan/.editinvim/' .. title .. '"'

    -- save last paste into a file, just in case we need it again
    local command = 'cp "' .. filename .. '" /Users/dan/.editinvim/lastpaste'
    os.execute(command)
    -- hs.alert.show(command,style,screen,20)

    local command = 'cat "' .. filename .. '" | pbcopy'
    os.execute(command)

    win:focus()

    hs.eventtap.keyStroke({'cmd'}, 'v')

    hs.pasteboard.setContents(savedclipboard)
    os.execute("sleep 3 && /bin/rm " .. filename .. " &")
end


-- function howitworks(arg)
--     hs.alert.show(arg)
--     local title = hs.window.focusedWindow():title()
--     local filename = '"/Users/dan/.editinvim/' .. title .. '"'
--     local command = 'pbpaste | textutil -stdin -format txt -convert txt -output ' .. filename
--
--     hs.alert.show(filename)
--     hs.pasteboard.setContents(command)
-- end

-- hs.hotkey.bind(right_command, '4', function()
--     howitworks("a")
-- end)

-- hs.hotkey.bind(right_command, '4', function()
-- end)
