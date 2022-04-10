local wezterm = require 'wezterm';

return {
  font = wezterm.font_with_fallback({"Hack", "HackGenNerd Console"}),
  window_background_opacity = 0.8,
  window_decorations = "RESIZE",
  enable_tab_bar = false,
  text_background_opacity = 0.1,
  color_scheme = "Tomorrow Night",
  font_size = 16.0,
  window_close_confirmation = "NeverPrompt",
  keys = {
    {key="q", mods="CMD", action="QuitApplication"},
  }
}

