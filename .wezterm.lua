-- Pull in the wezterm API

local wezterm = require 'wezterm'

local mux = wezterm.mux
local act = wezterm.action

-- Maximize on startup
wezterm.on('gui-startup', function()
  local tab, pane, window = mux.spawn_window({})
  window:gui_window():maximize()
end)
--
-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

wezterm.on('update-right-status', function(window, pane)
  window:set_left_status 'left'
  window:set_right_status 'right'
end)

config.use_fancy_tab_bar = false
config.show_tabs_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false

config.window_background_opacity                  = 1.0 -- ranges from 0.0 to 1.0
config.window_decorations                         = "RESIZE"
config.window_close_confirmation                  = "AlwaysPrompt"
-- config.tab_bar_at_bottom                          = true
config.use_fancy_tab_bar                          = false

config.inactive_pane_hsb                          = {
  saturation = 0.8,
  brightness = 0.6
}

config.font                                       = wezterm.font('JetBrains Mono')
config.font_size                                  = 10.5
config.line_height                                = 1

-- Disable dead keys - https://en.wikipedia.org/wiki/Dead_key
config.use_dead_keys                              = false
config.scrollback_lines                           = 5000

config.adjust_window_size_when_changing_font_size = false
config.hide_tab_bar_if_only_one_tab               = true

config.color_scheme                               = 'Dracula'

local primary_bg                                  = '#77767B';

local tab_bar_colors                              = {
  bg = primary_bg,
  active = {
    bg = primary_bg,
    fg = '110f0f',
  },
  inactive = {
    bg = primary_bg,
    fg = '#565f89',
    hover = {
      bg = '#414868',
      fg = '#bdc7f0',
    }
  },
  new = {
    bg = primary_bg,
    fg = '#bdc7f0',
    hover = {
      bg = primary_bg,
      fg = '#cfc9c2',
    }
  },
}

config.colors                                     = {
  tab_bar = {
    -- The color of the strip that goes along the top of the window
    -- (does not apply when fancy tab bar is in use)
    background = tab_bar_colors.bg,

    -- The active tab is the one that has focus in the window
    active_tab = {
      -- The color of the background area for the tab
      bg_color = tab_bar_colors.active.bg,
      -- The color of the text for the tab
      fg_color = tab_bar_colors.active.fg,

      -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
      -- label shown for this tab.
      -- The default is "Normal"
      intensity = 'Bold',

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
      bg_color = tab_bar_colors.inactive.bg,
      fg_color = tab_bar_colors.inactive.fg,
      italic = true

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab`.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over inactive tabs
    inactive_tab_hover = {
      bg_color = tab_bar_colors.inactive.hover.bg,
      fg_color = tab_bar_colors.inactive.hover.fg,
      italic = false,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab_hover`.
    },

    -- The new tab button that let you create new tabs
    new_tab = {
      bg_color = tab_bar_colors.new.bg,
      fg_color = tab_bar_colors.new.fg,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab`.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over the new tab button
    new_tab_hover = {
      bg_color = tab_bar_colors.new.hover.bg,
      fg_color = tab_bar_colors.new.hover.fg,
      -- italic = true,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab_hover`.
    },
  },
}
 
-- Key mappings
config.keys                                       = {
  -- { key = 'l', mods = 'CMD|SHIFT', action = act.ActivateTabRelative(1) },
  -- { key = 'h', mods = 'CMD|SHIFT', action = act.ActivateTabRelative(-1) },
  -- { key = 'j', mods = 'CMD', action = act.ActivatePaneDirection 'Down', },
  -- { key = 'i', mods = 'CMD', action = act.ActivatePaneDirection 'Up' },
  -- { key = 'n', mods = 'SHIFT|CMD', action = act.SpawnWindow },
  -- { key = 'PageUp', mods = 'CTRL', action = act.ActivateTabRelative(-1) },
  -- { key = 'PageDown', mods = 'CTRL', action = act.ActivateTabRelative(1) },
  -- { key = 'LeftArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Left' },
  -- { key = 'RightArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Right' },
  -- { key = 'UpArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Up' },
  -- { key = 'DownArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Down' },},
  -- { key = 't', mods = 'CMD', action = act.SpawnTab 'CurrentPaneDomain' },
  -- { key = 'Enter', mods = 'CMD', action = act.ActivateCopyMode },
  
  { key = '+', mods = 'CTRL', action = act.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
  { key = '0', mods = 'CTRL', action = act.ResetFontSize },
  { key = 'c', mods = 'CTRL', action = act.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
  { key = 'n', mods = 'CTRL', action = act.CharSelect { copy_on_select = true, copy_to ='ClipboardAndPrimarySelection' }},
  { key = ',', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Next' },
  { key = 'LeftArrow', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Right' },
  { key = 'UpArrow', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Up' },
  { key = 'DownArrow', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Down' },
  { key = 'f', mods = 'CTRL|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' }},
  { key = 'd', mods = 'CTRL|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }},
  { key = 't', mods = 'CTRL|SHIFT', action = act.CloseCurrentTab { confirm = true }},
  { key = 'y', mods = 'CTRL|SHIFT', action = act.CloseCurrentPane { confirm = true }},
  { key = '{', mods = 'CTRL|SHIFT', action = act.MoveTabRelative(-1) },
  { key = '}', mods = 'CTRL|SHIFT', action = act.MoveTabRelative(1) },
  { key = 'b', mods = 'CTRL|SHIFT', action = act.SendString '\x02' },
  { key = 'Enter', mods = 'CTRL|SHIFT', action = act.ActivateCopyMode },
  { key = 'k', mods = 'CTRL', action = act.Multiple {act.ClearScrollback 'ScrollbackAndViewport', act.SendKey { key = 'L', mods = 'CTRL' },},},
  { key = 'r', mods = 'CTRL|SHIFT', action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false, }, },
  { key = 'i', mods = 'CTRL|SHIFT', action = wezterm.action.ToggleFullScreen},
  { key = '/', mods = 'CTRL', action = act.PaneSelect },
  { key = '.', mods = 'CTRL', action = act.PaneSelect { mode = 'SwapWithActive', }, },
  { key = 'l', mods = 'SHIFT|CTRL', action = act.Search { CaseInSensitiveString = '' },},
  { key = ':', mods = 'SHIFT|CTRL', action = act.Search {Regex = '[a-f0-9]{6,}',},}
}

-- and finally, return the configuration to wezterm
return config


