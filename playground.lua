local currentapp = hs.application.frontmostApplication();
hs.tabs.enableForApp(currentapp)
tabs = hs.tabs.tabWindows(currentapp)

-- hs.tabs.focusTab(currentapp, 2)

for k,v in pairs(tabs) do
    hs.alert.show(k,20)
    hs.alert.show(v,20)
end
