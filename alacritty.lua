hs.hotkey.bind(return_modifier, 'space', function()
    local alacritty = hs.application.find("Alacritty")
    if alacritty == nil then hs.application.open("Alacritty", 0, true)
    else
        if alacritty:isFrontmost() then
            alacritty:hide()
        else
            hs.application.open("Alacritty", 0, true)
            -- hs.window.frontmostWindow():raise()
        end
    end
end)
