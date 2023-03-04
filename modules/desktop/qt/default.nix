{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.qt;
in {
  options.modules.desktop.qt = {enable = mkEnableOption "Qt";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      qt6.qtbase
    ];
  };
}
