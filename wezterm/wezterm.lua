local wezterm = require 'wezterm';

local LIGHT_COLORSCHEME = 'Github (base16)'
local LIGHT_BORDER = 'light grey'
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

return {
  -- Fonts
  font     	= wezterm.font("JetBrains Mono")                             	, -- [JetBrains Mono]
  font_size	= 12.0                                                       	, -- [12.0]

  -- Colors
  color_scheme  = color_scheme,
  default_cursor_style = 'BlinkingBlock',
  cursor_blink_ease_in = 'Constant',
  cursor_blink_ease_out = 'Constant',
  cursor_blink_rate = 600,

  colors = {
    cursor_bg = cursor_bg
  },

  -- Appearance
  window_background_opacity   	= 0.85,  -- [1.0] alpha channel value with floating point numbers
  macos_window_background_blur  = 100,   -- blur
  enable_tab_bar              	= false, -- [true]
  hide_tab_bar_if_only_one_tab	= false, -- [false] hide the tab bar when there is only a single tab in the window

  window_frame = {
    border_left_width = '0.25cell',
    border_right_width = '0.25cell',
    border_bottom_height = '0.10cell',
    border_left_color = border_color,
    border_right_color = border_color,
    border_bottom_color = border_color,
  }
}

