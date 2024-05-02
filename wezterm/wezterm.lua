local wezterm = require 'wezterm'
local act = wezterm.action

local LIGHT_COLORSCHEME = 'Catppuccin Latte'
local DARK_COLORSCHEME = 'Catppuccin Mocha'
local LIGHT_BORDER = '#f0f0f0'
local DARK_BORDER = '#303030'

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
local border_color = scheme_for_appearance(a, LIGHT_BORDER, DARK_BORDER)

-- folke/zen-mode.nvim integration
wezterm.on('user-var-changed', function(window, pane, name, value)
  local overrides = window:get_config_overrides() or {}
  if name == 'ZEN_MODE' then
    local incremental = value:find '+'
    local number_value = tonumber(value)
    if incremental ~= nil then
      while number_value > 0 do
        window:perform_action(act.IncreaseFontSize, pane)
        number_value = number_value - 1
      end
    elseif number_value < 0 then
      window:perform_action(act.ResetFontSize, pane)
      overrides.font_size = nil
    else
      overrides.font_size = number_value
    end
  end
  window:set_config_overrides(overrides)
end)

local c = {
  -- Fonts
  font = wezterm.font_with_fallback { 'JetBrains Mono', 'termicons' },
  font_size = 13.0,

  keys = {
    {
      key = 'd',
      mods = 'SUPER',
      action = act.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'd',
      mods = 'SUPER | SHIFT',
      action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'h',
      mods = 'SUPER',
      action = act.ActivatePaneDirection 'Left',
    },
    {
      key = 'j',
      mods = 'SUPER',
      action = act.ActivatePaneDirection 'Down',
    },
    {
      key = 'k',
      mods = 'SUPER',
      action = act.ActivatePaneDirection 'Up',
    },
    {
      key = 'l',
      mods = 'SUPER',
      action = act.ActivatePaneDirection 'Right',
    },
  },

  -- Colors
  color_scheme = scheme_for_appearance(a, LIGHT_COLORSCHEME, DARK_COLORSCHEME),
  default_cursor_style = 'BlinkingBar',
  cursor_blink_ease_in = 'Constant',
  cursor_blink_ease_out = 'Constant',
  cursor_blink_rate = 600,

  -- Appearance
  window_decorations = 'TITLE | RESIZE | MACOS_FORCE_ENABLE_SHADOW',
  window_frame = {
    active_titlebar_bg = border_color,
  },
  enable_scroll_bar = false,
  use_fancy_tab_bar = false,
  enable_tab_bar = true,
  tab_bar_at_bottom = true,

  macos_window_background_blur = 100, -- blur
  hide_tab_bar_if_only_one_tab = false, -- [false] hide the tab bar when there is only a single tab in the window
}

wezterm.plugin.require('https://github.com/nekowinston/wezterm-bar').apply_to_config(c, {
  position = 'bottom',
  max_width = 32,
  dividers = false, -- or "slant_left", "arrows", "rounded", false
  indicator = {
    leader = {
      enabled = true,
      off = '',
      on = '',
    },
    mode = {
      enabled = true,
      names = {
        resize_mode = 'RESIZE',
        copy_mode = 'VISUAL',
        search_mode = 'SEARCH',
      },
    },
  },
  tabs = {
    numerals = 'arabic', -- or "roman"
    pane_count = 'superscript', -- or "subscript", false
    brackets = {
      active = { '', ':' },
      inactive = { '', ':' },
    },
  },
  clock = { -- note that this overrides the whole set_right_status
    enabled = true,
    format = '%H:%M', -- use https://wezfurlong.org/wezterm/config/lua/wezterm.time/Time/format.html
  },
})

for i = 1, 8 do
  table.insert({
    key = tostring(i),
    mods = 'CTRL | ALT',
    action = act.MoveTab(i - 1),
  }, c.keys)
end

return c
