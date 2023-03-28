local M = {}
local wezterm = require 'wezterm'
local act = wezterm.action

M.leader = { key = "a", mods = "CTRL", }
M.keys = {
  { key = "a", mods = "LEADER|CTRL", action = act.SendString("\x01"), },
  { key = "%", mods = "LEADER", action = act.SplitHorizontal { domain = "CurrentPaneDomain"}, },
  { key = "\"", mods = "LEADER", action = act.SplitVertical { domain = "CurrentPaneDomain" }, },
}

-- M.mouse_maps = {}

-- M.tmux_maps = {}

return M
