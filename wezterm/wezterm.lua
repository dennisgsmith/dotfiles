local wezterm = require 'wezterm';

local LIGHT_COLORSCHEME = 'Github (base16)'
local DARK_COLORSCHEME = 'Github Dark'

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

 -- full list @ wezfurlong.org/wezterm/colorschemes/index.html
local function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return DARK_COLORSCHEME
  else
    return LIGHT_COLORSCHEME
  end
end

return {
  -- Fonts
  font     	= wezterm.font("JetBrains Mono")                             	, -- [JetBrains Mono]
  font_size	= 12.0                                                       	, -- [12.0]

  -- Colors
  color_scheme  = scheme_for_appearance(get_appearance()),
  default_cursor_style = 'BlinkingBlock',
  cursor_blink_ease_in = 'Constant',
  cursor_blink_ease_out = 'Constant',
  cursor_blink_rate = 600,

  -- Appearance
  window_background_opacity   	= 0.85  	, -- [1.0] alpha channel value with floating point numbers
  macos_window_background_blur  = 100	, -- blur
  enable_tab_bar              	= false	, -- [true]
  hide_tab_bar_if_only_one_tab	= false	, -- [false] hide the tab bar when there is only a single tab in the window
}

