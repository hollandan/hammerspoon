wifiWatcher = nil
lastSSID = hs.wifi.currentNetwork()

xfuckinityIndicator = hs.drawing.rectangle(hs.geometry.rect{0, 880, 1500, 20})
xfuckinityIndicator:setAlpha(.4)
xfuckinityIndicator:setFill(true)
xfuckinityIndicator:behavior("canJoinAllSpaces")

local trustedNetworks = {
    home = "HOME-8B62",
    nsg  = "nsg"
}

-- Here's the culprit for the whtie screen on reload:
-- local availableNetworks = hs.wifi.availableNetworks()

local availableNetworks = {}

if (lastSSID == "xfinitywifi") then
    xfuckinityIndicator:show()
else
    xfuckinityIndicator:hide()
end

function ssidChangedCallback()
    newSSID = hs.wifi.currentNetwork()

    -- xfinity is a fucking thief if
        --  any of my trusted networks are in hs.wifi.availableNetworks
        --  and
        --  I'm connected to xfinity, instead of one of them

    if (newSSID == "xfinitywifi") then

        for k,v in pairs(trustedNetworks) do
            for i, ival in ipairs(availableNetworks) do
                if trustedNetworks[k] == availableNetworks[i] then
                    hs.alert.show("xfinity hijacked your wifi connection", 8)
                    break
                end
            end
        end

        xfuckinityIndicator:show()
    else
        xfuckinityIndicator:hide()
    end

    lastSSID = newSSID
end

wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()
