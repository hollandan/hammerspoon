hs.hotkey.bind(return_modifier, 'space', function()
    local alacritty = hs.application.find("Alacritty")
    if alacritty:isFrontmost() then
        alacritty:hide()
    else
        hs.application.open("Alacritty", 0, true)
    end
end)

-- -- OLD
-- hs.hotkey.bind(return_modifier, 'space', function()
--     local currentapp = hs.application.frontmostApplication();
--     local out = os.execute("/Users/dan/dotfiles/linux/scripts/hotkeyalacritty " .. currentapp:name())
-- end)
