{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.wezterm;
in {
  options.modules.wezterm = {enable = mkEnableOption "Wezterm";};
  config = mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      # colorSchemes = {};
      # extraConfig = {};
    };
  };
}
