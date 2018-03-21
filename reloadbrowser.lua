-- Reload safari when files in directory change
function reloadSafari(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == '.css' then
        -- if file:sub(-4) == 'html' then
            doReload = true
        end
    end
    if doReload then
		-- https://gist.github.com/mietek/26b14a9846c2f9cca554
        hs.osascript.applescript([[
			if application "Safari" is running then
			tell application "Safari"
				repeat with theWindow in windows
				repeat 1 times
					try
					set windowTabs to tabs of theWindow
					on error
					exit repeat
					end try
					repeat with theTab in windowTabs
					if URL of theTab contains "css.html" then
						set theURL to URL of theTab
						set URL of theTab to theURL
					end if
					end repeat
				end repeat
				end repeat
			end tell
			end if
        ]])
    end
end
local mySafariWatcher = hs.pathwatcher.new(os.getenv('HOME') .. '/Dropbox/_hours/nsg-worklog/cssicons', reloadSafari):start()
hs.alert.show('Reload')




-- tell application "Safari"
-- 	activate
-- 	tell application "System Events"
-- 		tell process "Safari"
-- 			keystroke "r" using {command down}
-- 		end tell
-- 	end tell
-- end tell



-- tell application "Safari"
-- 	activate
-- 	tell current tab of window 1
-- 		open "/Users/dan/Dropbox/_hours/nsg-worklog/cssicons/css.html"
-- 	end tell
-- end tell
