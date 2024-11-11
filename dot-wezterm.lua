local wezterm = require("wezterm")

return {
	font = wezterm.font("Hack Nerd Font"),
	-- font = wezterm.font("JetBrains Mono"),
	font_size = 16.0,
	hide_tab_bar_if_only_one_tab = true,
	leader = { key = "a", mods = "CTRL" },
	hide_mouse_cursor_when_typing = false,

	keys = {
		-- Split pane vertically
		{ key = '"', mods = "LEADER|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

		-- Split pane horizontally
		{ key = "%", mods = "LEADER|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

		{ key = "w", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

		-- Select next pane
		{ key = "o", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Next") },

		-- Navigate panes using Vim-like motions
		{ key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },
		{ key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
		{ key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },

		{ key = "c", mods = "LEADER", action = wezterm.action.SpawnTab("DefaultDomain") },

		{ key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },

		{ key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },
	},
	-- Optional: Enable mouse support for easier pane switching
}
