wifiWatcher = nil
homeSSID = "HOME-8B62"
lastSSID = hs.wifi.currentNetwork()

local trustedNetworks = {
    home = "HOME-8B62",
    nsg  = "nsg"
}

function ssidChangedCallback()
    newSSID = hs.wifi.currentNetwork()

    -- To implement:
    -- xfinity is a fucking thief if
        --  any of my trusted networks are in hs.wifi.availableNetworks
        --  and
        --  I'm connected to xfinity, not one of them

    -- for now, just tell me when I connect to xfinity
    if (newSSID == "xfinitywifi") then
        hs.alert.show("xfinity hijacked your wifi connection", 10)
    end

    lastSSID = newSSID
end

wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()
