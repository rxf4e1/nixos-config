{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.widgets;
in {
  options.modules.desktop.widgets = {enable = mkEnableOption "Widgets";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      eww-wayland
      waybar
    ];
  };
}
