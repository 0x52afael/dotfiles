local wezterm = require("wezterm")
--local commands = require 'commands'
enable_input_method = true
local mux = wezterm.mux
local act = wezterm.action
local config = wezterm.config_builder()
config.font_size = 18
-- config.color_scheme = 'Catppuccin Latte (Gogh)'
config.color_scheme = "Catppuccin Frappe"
config.font = wezterm.font("JetBrains Mono")
config.automatically_reload_config = true
config.cursor_blink_rate = 0
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
wezterm.on("format-tab-title", function(tab)
	return string.format(" %d: %s ", tab.tab_index + 1, tab.active_pane.title)
end)

config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true
config.window_background_opacity = 0.6 -- adjust transparency (0.0–1.0)
config.macos_window_background_blur = 30
config.leader = { key = "a", mods = "CTRL" }

config.keys = {
	-- Split panes
	{ key = "v", mods = "LEADER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "s", mods = "LEADER", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{ key = "[", mods = "SHIFT|ALT", action = wezterm.action.SendString("{") },
	{ key = "]", mods = "SHIFT|ALT", action = wezterm.action.SendString("}") },

	-- Vim-style pane navigation
	{ key = "h", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
	{ key = "j", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
	{ key = "k", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	{ key = "l", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Right" }) },

	-- Optional: close pane
	{ key = "x", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
	-- Open yazi using ctrl+n
	{ key = "n", mods = "CMD", action = wezterm.action.SendString("yazi\n") },

	-- Optional: resize panes
	{ key = "LeftArrow", mods = "LEADER", action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }) },
	{ key = "DownArrow", mods = "LEADER", action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }) },
	{ key = "UpArrow", mods = "LEADER", action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }) },
	{ key = "RightArrow", mods = "LEADER", action = wezterm.action({ AdjustPaneSize = { "Right", 5 } }) },
	{ key = "1", mods = "CMD", action = wezterm.action.ActivateTab(0) },
	{ key = "2", mods = "CMD", action = wezterm.action.ActivateTab(1) },
	{ key = "3", mods = "CMD", action = wezterm.action.ActivateTab(2) },
	{ key = "4", mods = "CMD", action = wezterm.action.ActivateTab(3) },
	{ key = "5", mods = "CMD", action = wezterm.action.ActivateTab(4) },
	{ key = "6", mods = "CMD", action = wezterm.action.ActivateTab(5) },
	{ key = "7", mods = "CMD", action = wezterm.action.ActivateTab(6) },
	{ key = "8", mods = "CMD", action = wezterm.action.ActivateTab(7) },

	-- Enter copy mode (like tmux’s alt+v )
	{ key = "v", mods = "ALT", action = act.ActivateCopyMode },
}

-- Miscellaneous settings
config.max_fps = 120
config.prefer_egl = true

return config
