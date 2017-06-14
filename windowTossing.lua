-- shamelessly stolen from Greg Hurrel
-- -- https://github.com/wincent/wincent/tree/35d430520d525e8ac4c829f4436e5b42c8df5dd8/roles/dotfiles/files/.hammerspoon
-- and of course modified for my own purposes
local lastSeenChain = nil
local lastSeenWindow = nil

-- Chain the specified movement commands.
--
-- This is like the "chain" feature in Slate, but with a couple of enhancements:
--
--  - Chains always start on the screen the window is currently on.
--  - A chain will be reset after 2 seconds of inactivity, or on switching from
--    one chain to another, or on switching from one app to another, or from one
--    window to another.
--
chain = (function(movements)
  local chainResetInterval = 2 -- seconds
  local cycleLength = #movements
  local sequenceNumber = 1

  return function()
    local win = hs.window.frontmostWindow()
    local id = win:id()
    local now = hs.timer.secondsSinceEpoch()
    local screen = win:screen()

    if
      lastSeenChain ~= movements or
      lastSeenAt < now - chainResetInterval or
      lastSeenWindow ~= id
    then
      sequenceNumber = 1
      lastSeenChain = movements
    elseif (sequenceNumber == 1) then
      -- At end of chain, restart chain on next screen.
      screen = screen:next()
    end
    lastSeenAt = now
    lastSeenWindow = id

    hs.grid.set(win, movements[sequenceNumber], screen)
    sequenceNumber = sequenceNumber % cycleLength + 1
  end
end)

--
-- Key bindings.
--
local extraKeyCodes = {
  semicolon = 41,
}

hs.hotkey.bind({'ctrl', 'rightcmd'}, 'return', chain({
    grid.fullScreen
}))

hs.hotkey.bind({'ctrl', 'rightcmd'}, 'a', chain({
  grid.leftHalf,
  grid.leftThird,
  grid.leftTwoThirds,
}))

hs.hotkey.bind({'ctrl', 'rightcmd'}, extraKeyCodes.semicolon, chain({
  grid.rightHalf,
  grid.rightThird,
  grid.rightTwoThirds,
}))

hs.hotkey.bind({'ctrl', 'rightcmd'}, 'r', chain({
  grid.topHalf,
  grid.topThird,
  grid.topTwoThirds,
}))


hs.hotkey.bind({'ctrl', 'rightcmd'}, 'm', chain({
  grid.bottomHalf,
  grid.bottomThird,
  grid.bottomTwoThirds,
}))


hs.hotkey.bind({'ctrl', 'rightcmd'}, 'q', chain({
  grid.topLeft,
  grid.topRight,
  grid.bottomRight,
  grid.bottomLeft,
}))

hs.hotkey.bind({'ctrl', 'rightcmd'}, ',', chain({
  grid.fullScreen,
  grid.centeredBig,
  grid.centeredSmall,
}))
