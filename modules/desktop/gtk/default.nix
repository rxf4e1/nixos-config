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
  cfg = config.modules.desktop.gtk;
in {
  options.modules.desktop.gtk = {enable = mkEnableOption "Gtk";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # custom-cursor
      hicolor-icon-theme
      sweet
      # lxappearance-gtk2
    ];

    gtk = {
      enable = true;
      cursorTheme = {
        name = "Sweet-cursors";
        # name = "Nordzy-cursors";
        # package = pkgs.nordzy-cursor-theme;
        size = 24;
      };
      font = {
        name = "Fira Code";
        size = 9;
      };
      iconTheme.name = "candy-icons";
      theme = {
        name = "Sweet-Dark";
        package = pkgs.sweet;
      };

    };
  };
}
