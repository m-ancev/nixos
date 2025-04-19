local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Font configuration
config.font = wezterm.font("JetBrains Mono", { weight = 'Medium', italic = false })
config.font_size = 13.0

-- Color scheme
config.color_scheme = 'Black Metal (Gorgoroth) (base16)'
-- config.color_scheme = 'Brewer (light) (terminal.sexy)'

-- Default program (PowerShell on Windows)
config.default_prog = {"powershell.exe", "-NoLogo"}

-- Disable bell
config.audible_bell = "Disabled"

-- Default directory
config.default_cwd = wezterm.home_dir .. "/Desktop"

-- Window padding
config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}

-- Tab bar settings
config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

-- Define leader key
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

-- Key bindings
config.keys = {
  -- Spawn a new tab with CTRL+SHIFT+T
  { key = "T", mods = "CTRL|SHIFT", action = act.SpawnTab("CurrentPaneDomain") },
  -- Execute last command with CTRL+p:
  -- Sends Ctrl+C to cancel, UpArrow to recall the last command, then Enter to execute it.
  {
      key = "p", mods = "CTRL|SHIFT", action = act.Multiple
      ({
        act.SendKey({ key = "C", mods = "CTRL" }),
        act.SendKey({ key = "L", mods = "CTRL" }),
        act.SendKey({ key = "UpArrow" }),
        act.SendKey({ key = "Enter" }),
      })
  },
  -- Enter copy mode (vi-like bindings)
  { key = "Enter", mods = "LEADER", action = act.ActivateCopyMode },
}

return config
