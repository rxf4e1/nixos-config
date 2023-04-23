local wezterm = require("wezterm")

-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

local config = {}
config = {

  -- defaults
  term = 'wezterm',
  automatically_reload_config = true,

  font = wezterm.font({
    family = "Fira Code",
    harfbuzz_features = {
      -- "zero", -- alternative 0
      -- "cv02", -- alternative g
      "cv25", -- .- ligature
      "cv26", -- :- ligature
      "cv27", -- [] ligature
      "cv30", -- longer bar
      "ss01", -- alternative r
      -- "ss03", -- alternative & ampersand
      -- "ss05", -- different @ sign
      "ss07", -- =~ !~ ligatures
      "ss09", -- >>= <<= ||= |= ligatures
    },
  }),
  font_size = 9.0,
  bold_brightens_ansi_colors = false,

  -- color = custom,
  color_scheme = 'Dracula (Official)',

  -- cursor
  default_cursor_style = "BlinkingUnderline",

  -- alert
  audible_bell = "Disabled",
  visual_bell = {
    fade_in_duration_ms = 100,
    fade_out_duration_ms = 100,
    target = "CursorColor",
  },
  
  -- window
  window_decorations = "NONE",
  window_background_opacity = 0.95,
  inactive_pane_hsb = { saturation = 0.8, brightness = 0.4, },
  window_padding = { left = 0, right = 0, top = 0, bottom = 0, },
  window_close_confirmation = "NeverPrompt",

  -- tabs
  enable_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,
  tab_max_width = 25,
  show_tab_index_in_tab_bar = false,

  --
  -- keymaps
  -- disable_default_key_bindings = true,
  -- keys = keymaps,
  -- mousemaps
  --

}

return config
