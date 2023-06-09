{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  # custom-cursor = import (pkgs.fetchFromGitHub {
  #   owner = "EliverLara";
  #   repo = "Sweet";
  #   rev = "f0957eec6bea8752449308ccb8c325d199c129";
  #   sha256 = "06h5w71qfb32khfaggqlpi8wzhbw4g18ggs18bwhz9nxnjbdr7lb";
  # });
  # custom-icons = (fetchFromGitHub "");
  cfg = config.modules.desktop.qt;
in {
  options.modules.desktop.qt = {enable = mkEnableOption "Qt";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # custom-cursor
      hicolor-icon-theme
      sweet
      libsForQt5.qtstyleplugins
      libsForQt5.qt5ct
    ];

    qt = {
      enable = true;
      platformTheme = null;
      style = {
        package = pkgs.libsForQt5.breeze-qt5;
        # package = pkgs.lightly-qt;
        name = "bb10dark";
      };
    };
  };
}
