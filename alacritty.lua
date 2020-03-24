hs.hotkey.bind(return_modifier, 'space', function()
    -- when alacritty can be hidden without breaking
    -- -- if alacritty is visible, hide
    -- -- else                     show

    local currentapp = hs.application.frontmostApplication();
    -- hs.alert.show(currentapp:name())
    -- hs.execute("/Users/dan/dotfiles/linux/scripts/hotkeyalacritty")
    local out = os.execute("/Users/dan/dotfiles/linux/scripts/hotkeyalacritty " .. currentapp:name())

end)

hs.hotkey.bind(return_modifier, '1', function()
    local out = os.execute("~/.config/alacritty/opacity 1")
end)

hs.hotkey.bind(return_modifier, '2', function()
    local out = os.execute("~/.config/alacritty/opacity 2")
end)

hs.hotkey.bind(return_modifier, '2', function()
    local out = os.execute("~/.config/alacritty/opacity 2")
end)

hs.hotkey.bind(return_modifier, '3', function()
    local out = os.execute("~/.config/alacritty/opacity 3")
end)

hs.hotkey.bind(return_modifier, '4', function()
    local out = os.execute("~/.config/alacritty/opacity 4")
end)

hs.hotkey.bind(return_modifier, '5', function()
    local out = os.execute("~/.config/alacritty/opacity 5")
end)

hs.hotkey.bind(return_modifier, '6', function()
    local out = os.execute("~/.config/alacritty/opacity 6")
end)

hs.hotkey.bind(return_modifier, '7', function()
    local out = os.execute("~/.config/alacritty/opacity 7")
end)

hs.hotkey.bind(return_modifier, '8', function()
    local out = os.execute("~/.config/alacritty/opacity 8")
end)

hs.hotkey.bind(return_modifier, '9', function()
    local out = os.execute("~/.config/alacritty/opacity 9")
end)

hs.hotkey.bind(return_modifier, '0', function()
    local out = hs.execute("~/.config/alacritty/opacity 0")
end)
