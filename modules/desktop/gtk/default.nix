{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.gtk;
in {
  options.modules.desktop.gtk = {enable = mkEnableOption "Gtk";};
  config = mkIf cfg.enable {
    home.packages = [pkgs.hicolor-icon-theme];
    gtk = {
      enable = true;
      cursorTheme = {
        name = "Punk";
        # name = "Nordzy-cursors";
        # package = pkgs.nordzy-cursor-theme;
        size = 24;
      };
      font = {
        name = "Monospace";
        size = 10;
      };
      iconTheme.name = "candy-icons";
      theme = {
        name = "Sweet-Dark";
        package = pkgs.sweet;
      };
    };
  };
}
