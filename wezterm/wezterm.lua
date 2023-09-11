local wezterm = require 'wezterm';

local LIGHT_COLORSCHEME = 'Github (base16)'
local LIGHT_BORDER = '#f0f0f0'
local LIGHT_CURSOR = 'black'
local DARK_COLORSCHEME = 'Github Dark'
local DARK_BORDER = '#303030'
local DARK_CURSOR = '#ffffff'

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return 'Dark'
end

-- full list @ wezfurlong.org/wezterm/colorschemes/index.html
local function scheme_for_appearance(appearance, light_theme, dark_theme)
	if appearance:find 'Dark' then
		return dark_theme
	else
		return light_theme
	end
end

local a = get_appearance()
local color_scheme = scheme_for_appearance(a, LIGHT_COLORSCHEME, DARK_COLORSCHEME)
local border_color = scheme_for_appearance(a, LIGHT_BORDER, DARK_BORDER)
local cursor_bg = scheme_for_appearance(a, LIGHT_CURSOR, DARK_CURSOR)

-- folke/zen-mode.nvim integration
wezterm.on('user-var-changed', function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while (number_value > 0) do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
		else
			overrides.font_size = number_value
		end
	end
	window:set_config_overrides(overrides)
end)

return {
	-- Fonts
	font                         = wezterm.font_with_fallback({ "JetBrains Mono", "termicons" }),
	font_size                    = 13.0,

	keys                         = {
		{
			key = 'd',
			mods = 'SUPER | SHIFT',
			action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
		},
		{
			key = 'd',
			mods = 'SUPER',
			action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
		},
	},

	-- Colors
	color_scheme                 = color_scheme,
	default_cursor_style         = 'BlinkingBar',
	cursor_blink_ease_in         = 'Constant',
	cursor_blink_ease_out        = 'Constant',
	cursor_blink_rate            = 600,
	colors                       = {
		cursor_bg = cursor_bg,
		tab_bar = {
			-- The active tab is the one that has focus in the window
			active_tab = {
				-- The color of the background area for the tab
				bg_color = scheme_for_appearance(a, '#fdfdfd', '#222222'),
				-- The color of the text for the tab
				fg_color = scheme_for_appearance(a, '#0f0f0f', '#f0f0f0'),

				-- Specify whether you want "Half", "Normal" or "Bold" intensity for the
				-- label shown for this tab.
				-- The default is "Normal"
				intensity = 'Half',

				-- Specify whether you want "None", "Single" or "Double" underline for
				-- label shown for this tab.
				-- The default is "None"
				underline = 'None',

				-- Specify whether you want the text to be italic (true) or not (false)
				-- for this tab.  The default is false.
				italic = false,

				-- Specify whether you want the text to be rendered with strikethrough (true)
				-- or not for this tab.  The default is false.
				strikethrough = false,
			},

			-- Inactive tabs are the tabs that do not have focus
			inactive_tab = {
				bg_color = scheme_for_appearance(a, '#e6e6e6', '#444444'),
				fg_color = scheme_for_appearance(a, '#0f0f0f', '#e0e0e0'),

				-- The same options that were listed under the `active_tab` section above
				-- can also be used for `inactive_tab`.
			},

			-- You can configure some alternate styling when the mouse pointer
			-- moves over inactive tabs
			inactive_tab_hover = {
				bg_color = scheme_for_appearance(a, '#d0d0d0', '#a0a0a0'),
				fg_color = scheme_for_appearance(a, '#ffffff', '#0a0a0a'),
				italic = true,

				-- The same options that were listed under the `active_tab` section above
				-- can also be used for `inactive_tab_hover`.
			},

			-- The new tab button that let you create new tabs
			new_tab = {
				bg_color = border_color,
				fg_color = scheme_for_appearance(a, '#808080', '#a0a0a0'),

				-- The same options that were listed under the `active_tab` section above
				-- can also be used for `new_tab`.
			},

			-- You can configure some alternate styling when the mouse pointer
			-- moves over the new tab button
			new_tab_hover = {
				bg_color = border_color,
				fg_color = cursor_bg,
				italic = true,

				-- The same options that were listed under the `active_tab` section above
				-- can also be used for `new_tab_hover`.
			},
		},
	},

	-- Appearance
	window_decorations           = "TITLE | RESIZE | MACOS_FORCE_ENABLE_SHADOW",
	window_frame                 = {
		active_titlebar_bg = border_color,
	},
	enable_tab_bar               = false,

	macos_window_background_blur = 100, -- blur
	hide_tab_bar_if_only_one_tab = false, -- [false] hide the tab bar when there is only a single tab in the window
}
