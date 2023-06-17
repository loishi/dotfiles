local wezterm = require 'wezterm';

return {
  font = wezterm.font_with_fallback({"Hack Nerd Font", "Noto Sans JP", "Noto Sans"}),
  window_background_opacity = 0.75,
  window_decorations = "RESIZE",
  enable_tab_bar = false,
  text_background_opacity = 0.4,
  color_scheme = "Tomorrow Night",
  font_size = 16;
  window_close_confirmation = "NeverPrompt",
  window_padding = {
    top = 0,
    left = 0,
    right = 0,
    bottom = 0,
  },
  keys = {
    {key="q", mods="CMD", action="QuitApplication"},
  }
}

