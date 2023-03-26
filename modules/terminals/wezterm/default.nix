{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.terminal.emu.wezterm;
in {
  options.modules.terminal.emu.wezterm = {enable = mkEnableOption "Wezterm";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      wezterm
    ];

    # programs.wezterm = {
    #   enable = true;
    #   extraConfig = ''
    #     local wezterm = require 'wezterm';
    #     return {
    #       check_for_updates = false,
    #       font = wezterm.font_with_fallback({
    #         "FiraCode Nerd Font Mono",
    #         "Symbols Nerd Font Mono",
    #       }),
    #       font_size = 9.0,
    #       window_decorations = "NONE",
    #       enable_tab_bar = false,
    #       default_cursor_style = "SteadyBlock",
    #       force_reverse_video_cursor = true,
    #     };
    #   '';
    # };
  };
}
